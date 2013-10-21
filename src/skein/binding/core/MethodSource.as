/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/30/13
 * Time: 2:10 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.core
{
public class MethodSource extends SourceBase implements Source
{
    public function MethodSource(host:Object, getter:String, params:Array=null)
    {
        super();

        this.host = host;
        this.getter = getter;
        this.params = params;

        this.watcher = Watcher.watch(host, getter, this.handler);
    }

    private var watcher:Watcher;

    private var host:Object;
    private var getter:String;
    private var params:Array;

    override public function getValue():Object
    {
        var value:* = watcher.getValue(params);

        return value;

        var f:Function = host[getter];

        return f.apply(host, params);

//        return this.host[this.getter]();
    }

    override public function dispose():void
    {
        this.watcher.reset(null);
    }
}
}
