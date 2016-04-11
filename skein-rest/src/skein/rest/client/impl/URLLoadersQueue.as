/**
 * Created by Max Rozdobudko on 10/8/15.
 */
package skein.rest.client.impl
{
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import skein.rest.core.Config;

import skein.utils.ByteArrayUtil;

public class URLLoadersQueue
{
    private static const queue:Array = [];

    private static const requests:Dictionary = new Dictionary();

    private static const serials:Dictionary = new Dictionary(true); // don't keep loader strongly here

    public static function find(request:URLRequest):URLLoader
    {
        if (!Config.sharedInstance().useQueue)
            return null;

        for (var i:int = queue.length; i > 0; i--)
        {
            var loader:URLLoader = queue[i - 1];

            if (compare(request, requests[loader]))
            {
                return loader;
            }
        }

        return null;
    }

    public static function keep(request:URLRequest, loader:URLLoader):void
    {
        if (!Config.sharedInstance().useQueue)
        {
            serials[loader] = getNextSerialName();
            return;
        }

        if (queue.indexOf(loader) == -1)
        {
            queue.push(loader);

            requests[loader] = request;

            serials[loader] = getNextSerialName();
        }
    }

    /**
     * Removes specified loader from queue and returns <code>true</code> if the
     * loader was in queue. If queue is disabled in config, this method always
     * returns <code>true</code>.
     *
     * @param loader An URLLoader instance to be removed from queue.
     * @return <code>true</code> if specified loader was in queue and has been
     * successfully removed or Queue is disabled in Config, or <code>false</code>
     * if queue doesn't contain the loader.
     */
    public static function free(loader:URLLoader):Boolean
    {
        if (!Config.sharedInstance().useQueue)
        {
            serials[loader] = null;
            delete serials[loader];
            
            return true;
        }

        if (queue.indexOf(loader) != -1)
        {
            queue.splice(queue.indexOf(loader), 1);

            requests[loader] = null;
            delete requests[loader];

            serials[loader] = null;
            delete serials[loader];

            return true;
        }
        else
        {
            return false;
        }
    }

    public static function name(loader:URLLoader):String
    {
        return serials[loader] || "xxxx";
    }

    private static function compare(r1:URLRequest, r2:URLRequest):Boolean
    {
        var result:Boolean = r1.url == r2.url && r1.method == r2.method;

        if (r1.hasOwnProperty("cacheResponse"))
            result = result && r1["cacheResponse"] == r2["cacheResponse"];

        if (r1.hasOwnProperty("authenticate"))
            result = result && r1["authenticate"] == r2["authenticate"];

        if (result)
        {
            if (r1.data != r2.data)
            {
                var ba1:ByteArray = new ByteArray();
                ba1.writeObject(ba1);

                var ba2:ByteArray = new ByteArray();
                ba2.writeObject(ba2);

                result = ByteArrayUtil.compare(ba1, ba2);
            }
        }

        return result;
    }

    private static var _serialNumber:int = 0;

    private static function getNextSerialName():String
    {
        _serialNumber = _serialNumber + 1;

        if (_serialNumber > 9999)
        {
            _serialNumber = 0;
        }

        var zeros:String = "0000";

        return zeros.substr(0, zeros.length - String(_serialNumber).length) + String(_serialNumber);
    }
}
}
