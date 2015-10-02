/**
 * Created by Max Rozdobudko on 10/2/15.
 */
package skein.rest.cache
{
import flash.net.URLRequest;

public interface CacheStorage
{
    function init():void;

    function live(url:String):Boolean;

    function find(url:String):Object;

    function keep(url:String, data:Object, headers:Array):Boolean;
}
}
