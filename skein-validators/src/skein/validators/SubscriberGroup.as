/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/18/13
 * Time: 10:17 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.validators
{
import skein.validators.events.SubscriberEvent;
import skein.validators.events.ValidationEvent;

public class SubscriberGroup
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function SubscriberGroup()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    public var subscribers:Array = [];

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //--------------------------------------
    //  Methods: Public API
    //--------------------------------------

    public function init():void
    {
        registerSubscribers();
    }

    //--------------------------------------
    //  Methods: Internal
    //--------------------------------------

    private function registerSubscribers():void
    {
        for each (var subscriber:Subscriber in subscribers)
        {
            subscriber.addEventListener(SubscriberEvent.LISTENER_CHANGE, subscriber_listenerChangeHandler);
            subscriber.addEventListener(SubscriberEvent.VALIDATOR_CHANGE, subscriber_validatorChangeHandler);
//
//            bind(setter(this, "listenerChange"), get(subscriber, "listener"));
//            bind(setter(this, "validatorChange"), get(subscriber, "validator"));
        }
    }

//    private var listenerCount:uint;
//
//    public function listenerChange(listener:Object):void
//    {
//        if (listener != null)
//        {
//            listenerCount++;
//        }
//
//        if (listenerCount == subscribers.length && validatorCount == subscribers.length)
//        {
//            initSubscribers();
//        }
//    }
//
//    private var validatorCount:uint;
//
//    public function validatorChange(validator:Validator):void
//    {
//        if (validator != null)
//        {
//            validatorCount++;
//        }
//
//        if (validatorCount == subscribers.length && listenerCount == subscribers.length)
//        {
//            initSubscribers();
//        }
//    }
//
//    private function initSubscribers():void
//    {
//        for each (var subscriber:Subscriber in subscribers)
//        {
//            if (subscriber.listener != null)
//            {
//                registerValidationEvents(subscriber.validator);
//            }
//        }
//    }

    private function getSubscriberByValidator(validator:Validator):Subscriber
    {
        for each (var subscriber:Subscriber in subscribers)
        {
            if (subscriber.validator == validator)
                return subscriber;
        }

        return null;
    }

    private function getSubscriberByListener(listener:Object):Subscriber
    {
        for each (var subscriber:Subscriber in subscribers)
        {
            if (subscriber.listener == listener)
                return subscriber;
        }

        return null;
    }

//    private function subscribeControl(listener:Object):void
//    {
//
//    }
//
//    private function registerValidationEvents(validator:Validator):void
//    {
//        validator.addEventListener(ValidationEvent.VALID, validationResultHandler);
//        validator.addEventListener(ValidationEvent.INVALID, validationResultHandler);
//    }

    //--------------------------------------------------------------------------
    //
    //  Handlers
    //
    //--------------------------------------------------------------------------

    private function validationResultHandler(event:ValidationEvent):void
    {
        var subscriber:Subscriber = getSubscriberByValidator(event.target as Validator);

        var listener:Object = subscriber.listener;

        if (event.type == ValidationEvent.VALID)
        {
            if (listener != null && listener.hasOwnProperty("errorString"))
            {
                listener.errorString = null;
            }
        }
        else // if (event.type == ValidationEvent.INVALID)
        {
            if (listener != null && listener.hasOwnProperty("errorString"))
            {
                listener.errorString = event.results[0].errorMessage;
            }
        }
    }

    private function subscriber_listenerChangeHandler(event:SubscriberEvent):void
    {

    }

    private function subscriber_validatorChangeHandler(event:SubscriberEvent):void
    {
        if (event.oldValue is Validator)
        {
            Validator(event.oldValue).removeEventListener(ValidationEvent.VALID, validationResultHandler);
            Validator(event.oldValue).removeEventListener(ValidationEvent.INVALID, validationResultHandler);
        }

        if (event.newValue)
        {
            Validator(event.newValue).addEventListener(ValidationEvent.VALID, validationResultHandler);
            Validator(event.newValue).addEventListener(ValidationEvent.INVALID, validationResultHandler);
        }
    }
}
}
