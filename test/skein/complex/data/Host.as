/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/17/13
 * Time: 12:20 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.complex.data
{
import flash.events.Event;
import flash.events.EventDispatcher;

public class Host extends EventDispatcher implements IHost
{
    public function Host()
    {
    }

    private var _source:Object;

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
}
}
