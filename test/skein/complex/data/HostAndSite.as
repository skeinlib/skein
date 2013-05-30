/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/17/13
 * Time: 11:54 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.complex.data
{
import flash.events.Event;
import flash.events.EventDispatcher;

public class HostAndSite extends EventDispatcher implements IHost, ISite
{
    public function HostAndSite()
    {
        super();
    }

    [Bindable(event="sourceChanged")]
    public function get source():Object
    {
        return _source;
    }

    public function set source(value:Object):void
    {
        if (_source == value) return;
        _source = value;
        dispatchEvent(new Event("sourceChanged"));
    }

    private var _source:Object;

    private var _destination:Object;
    public function get destination():Object
    {
        return _destination;
    }

    public function set destination(value:Object):void
    {
        if (_destination == value) return;
        _destination = value;

        trace(_destination);
    }
}
}
