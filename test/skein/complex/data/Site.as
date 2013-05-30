/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/17/13
 * Time: 11:54 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.complex.data
{
import flash.events.EventDispatcher;

public class Site extends EventDispatcher implements ISite
{
    public function Site()
    {
    }

    private var _destination:Object;
    public function get destination():Object
    {
        return _destination;
    }

    public function set destination(value:Object):void
    {
        if (_destination == value) return;
        _destination = value;
    }
}
}
