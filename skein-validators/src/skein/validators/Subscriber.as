/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/18/13
 * Time: 10:15 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.validators
{
import flash.events.Event;
import flash.events.EventDispatcher;

import skein.validators.events.SubscriberEvent;

[Event(name="listenerChange", type="skein.validators.events.SubscriberEvent")]
[Event(name="validatorChange", type="skein.validators.events.SubscriberEvent")]
public class Subscriber extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Subscriber()
    {
        super()
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //--------------------------------------
    //  validator
    //--------------------------------------

    private var _validator:Validator;

    [Bindable(event="validatorChange")]
    public function get validator():Validator
    {
        return _validator;
    }

    public function set validator(value:Validator):void
    {
        if (_validator == value) return;

        var oldValue:Object = _validator;

        _validator = value;

        dispatchEvent(new SubscriberEvent(SubscriberEvent.VALIDATOR_CHANGE, oldValue, _validator));
    }

    //--------------------------------------
    //  listener
    //--------------------------------------

    private var _listener:Object;

    [Bindable(event="listenerChanged")]
    public function get listener():Object
    {
        return _listener;
    }

    public function set listener(value:Object):void
    {
        if (_listener == value) return;

        var oldValue:Object = _listener;

        _listener = value;

        dispatchEvent(new SubscriberEvent(SubscriberEvent.LISTENER_CHANGE, oldValue, _listener));
    }
}
}
