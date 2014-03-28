/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 2/26/14
 * Time: 12:08 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.core
{
import skein.core.skein_internal;

public class HeaderHandler
{
    private static const handlers:Object = {};

    public static function forName(name:String):Function
    {
        return handlers[name];
    }

    public static function hasHandler(name:String):Boolean
    {
        return handlers.hasOwnProperty(name);
    }

    public static function hasHandlers():Boolean
    {
        for (var p:String in handlers)
            return true;

        return false;
    }

    skein_internal static function register(name:String, handler:Function):void
    {
        handlers[name] = handler;
    }
}
}
