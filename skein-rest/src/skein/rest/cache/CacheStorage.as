/**
 * Created by Max Rozdobudko on 10/2/15.
 */
package skein.rest.cache
{
import skein.rest.cache.response.Head;
import skein.rest.cache.response.Response;

public interface CacheStorage
{
    function head(url:String):Head;

    function find(url:String, callback:Function):void;

    function keep(url:String, response:Response, callback:Function = null):Boolean;

    function purge():void;
}
}
