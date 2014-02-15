/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/18/13
 * Time: 10:17 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.validators
{
import skein.binding.bind;
import skein.binding.get;
import skein.binding.setter;
import skein.validators.events.ValidationEvent;

public class SubscriberGroup
{
    public function SubscriberGroup()
    {
        super();
    }

    public var subscribers:Array = [];

    public function init():void
    {
        registerSubscribers();
    }

    private function registerSubscribers():void
    {
        for each (var subscriber:Subscriber in subscribers)
        {
            bind(setter(this, "listenerChange"), get(subscriber, "listener"));
            bind(setter(this, "validatorChange"), get(subscriber, "validator"));
        }
    }

    private var listenerCount:uint;

    public function listenerChange(listener:Object):void
    {
        if (listener != null)
        {
            listenerCount++;
        }

        if (listenerCount == subscribers.length && validatorCount == subscribers.length)
        {
            initSubscribers();
        }
    }

    private var validatorCount:uint;

    public function validatorChange(validator:Validator):void
    {
        if (validator != null)
        {
            validatorCount++;
        }

        if (validatorCount == subscribers.length && listenerCount == subscribers.length)
        {
            initSubscribers();
        }
    }

    private function initSubscribers():void
    {
        for each (var subscriber:Subscriber in subscribers)
        {
            if (subscriber.listener != null)
            {
                registerValidationEvents(subscriber.validator);
            }
        }
    }

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


    private function subscribeControl(listener:Object):void
    {

    }

    private function registerValidationEvents(validator:Validator):void
    {
        validator.addEventListener(ValidationEvent.VALID, validationResultHandler);
        validator.addEventListener(ValidationEvent.INVALID, validationResultHandler);
    }

    private function validationResultHandler(event:ValidationEvent):void
    {
        var subscriber:Subscriber = getSubscriberByValidator(event.target as Validator);

        var listener:Object = subscriber.listener;

        if (event.type == ValidationEvent.VALID)
        {
            if (listener.hasOwnProperty("errorString"))
            {
                listener.errorString = null;
            }
        }
        else // if (event.type == ValidationEvent.INVALID)
        {
            if (listener.hasOwnProperty("errorString"))
            {
                listener.errorString = event.results[0].errorMessage;
            }
        }
    }
}
}
