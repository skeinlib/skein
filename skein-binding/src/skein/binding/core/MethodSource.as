/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/30/13
 * Time: 2:10 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.core
{

public class MethodSource extends SourceBase
{
    public function MethodSource(host:Object, getter:String, params:Array=null)
    {
        super(host);

        this.getter = getter;
        this.params = params;

        this.watcher = Watcher.watch(host, getter, this.handler);
    }

    private var watcher:Watcher;


    private var getter:String;
    private var params:Array;

    override public function getValue():Object
    {
        var paramValues:Array = [];

        for each (var object:Object in params)
        {
            paramValues.push(OperatorBase.getOperandValue(object));
        }

        return watcher.getValue(paramValues);
    }

    override public function dispose():void
    {
        this.watcher.unwatch();
    }
}
}
