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
    public function MethodSource(host:Object, getter:String)
    {
        super();

        this.host = host;
        this.getter = getter;
    }

    private var host:Object;
    private var getter:String;

    override public function getValue():Object
    {
        return this.host[this.getter]();
    }
}
}
