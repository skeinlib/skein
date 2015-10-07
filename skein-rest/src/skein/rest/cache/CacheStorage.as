/**
 * Created by Max Rozdobudko on 10/2/15.
 */
package skein.rest.cache
{
import skein.rest.cache.response.Headers;

public interface CacheStorage
{
    function head(url:String):Headers;

    function find(url:String, callback:Function):void;

    function keep(url:String, data:Object, headers:Headers, callback:Function = null):Boolean;

}
}
