/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 9/9/14
 * Time: 2:23 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.validators.events
{
import flash.events.Event;

public class SubscriberEvent extends Event
{
    public static const LISTENER_CHANGE:String = "listenerChange";

    public static const VALIDATOR_CHANGE:String = "validatorChange";

    public function SubscriberEvent(type:String, oldValue:Object, newValue:Object, bubbles:Boolean = false, cancelable:Boolean = false)
    {
        super(type, bubbles, cancelable);

        _oldValue = oldValue;
        _newValue = newValue;
    }

    private var _oldValue:Object;

    public function get oldValue():Object
    {
        return _oldValue;
    }

    private var _newValue:Object;
    public function get newValue():Object
    {
        return _newValue;
    }
}
}
