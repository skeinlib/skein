/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/22/13
 * Time: 10:59 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.core
{
import skein.core.Reference;
import skein.core.WeakReference;

public class PropertySource extends SourceBase
{
    public function PropertySource(host:Object, property:String)
    {
        super(host);

        this.watcher = Watcher.watch(host, property, this.handler);
    }

    private var watcher:Watcher;

    override public function getValue():Object
    {
        return watcher.getValue();
    }

    override public function dispose():void
    {
        watcher.unwatch();
    }
}
}
