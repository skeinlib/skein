/**
 * Created by Max Rozdobudko on 10/2/15.
 */
package skein.rest.cache
{
import flash.net.URLRequest;

public interface CacheStorage
{
    function live(url:String):Boolean

    function find(url:String, callback:Function):void;

    function keep(url:String, data:Object, headers:Array):Boolean;
}
}
