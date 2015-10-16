/**
 * Created by Max Rozdobudko on 10/8/15.
 */
package skein.rest.client.impl
{
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

public class URLLoadersQueue
{
    private static const queue:Array = [];

    private static const requests:Dictionary = new Dictionary();

    public static function find(request:URLRequest):URLLoader
    {
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
        if (queue.indexOf(loader) == -1)
        {
            queue.push(loader);

            requests[loader] = request;
        }
    }

    /**
     * Removes specified loader from queue and returns <code>true</code> if the
     * loader was in queue.
     *
     * @param loader An URLLoader instance to be removed from queue.
     * @return <code>true</code> if specified loader was in queue and has been
     * successfully removed, or <code>false</code> if queue doesn't contain the
     * loader.
     */
    public static function free(loader:URLLoader):Boolean
    {
        if (queue.indexOf(loader) != -1)
        {
            queue.splice(queue.indexOf(loader), 1);

            requests[loader] = null;
            delete requests[loader];

            return true;
        }
        else
        {
            return false;
        }
    }

    private static function compare(r1:URLRequest, r2:URLRequest):Boolean
    {
        var result:Boolean =
            r1.url == r2.url &&
            r1.method == r2.method &&
            r1.cacheResponse == r2.cacheResponse &&
            r1.authenticate == r2.authenticate;

        if (result)
        {
            if (r1.data != r2.data)
            {
                var ba1:ByteArray = new ByteArray();
                ba1.writeObject(ba1);

                var ba2:ByteArray = new ByteArray();
                ba2.writeObject(ba2);

                result = ba1.length == ba2.length;
            }
        }

        return result;
    }
}
}
