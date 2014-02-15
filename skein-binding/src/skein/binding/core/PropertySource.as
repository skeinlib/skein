/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/22/13
 * Time: 10:59 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.core
{
public class PropertySource extends SourceBase
{
    public function PropertySource(host:Object, property:String)
    {
        super();

        this.watcher = Watcher.watch(host, property, this.handler);
    }

    private var watcher:Watcher;

    override public function getValue():Object
    {
        return watcher.getValue();
    }

    override public function dispose():void
    {
        this.watcher.reset(null);
    }
}
}
