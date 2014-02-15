/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/5/13
 * Time: 11:27 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding
{
import skein.binding.core.Watcher;

public class BindingUtil
{
    public static function bindProperty(site:Object, property:String, host:Object, chain:Object):void
    {
        var watcher:Watcher = Watcher.watch(host, chain, null);

        if (watcher)
        {
            var assign:Function = function():void
            {
                site[property] = watcher.getValue();
            }

            watcher.setHandler(assign);
            assign();
        }
    }

    public static function bindSetter(setter:Function, host:Object, chain:Object):void
    {
        var watcher:Watcher = Watcher.watch(host, chain, null);

        if (watcher)
        {
            var assign:Function = function():void
            {
                setter(watcher.getValue());
            }

            watcher.setHandler(assign);
            assign();
        }

    }
}
}
