/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/18/13
 * Time: 10:51 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.validation.validators
{
import flash.events.EventDispatcher;

import skein.validation.Validator;
import skein.validation.data.ValidationResult;
import skein.validation.events.ValidationEvent;

public class BasicValidator extends EventDispatcher implements Validator
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function BasicValidator()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  source
    //-------------------------------------

    private var _source:Object;

    public function get source():Object
    {
        return _source;
    }

    public function set source(value:Object):void
    {
        removeTriggerEvent();

        _source = value;

        addTriggerEvent();
    }

    //-------------------------------------
    //  property
    //-------------------------------------

    private var _property:String;

    public function get property():String
    {
        return _property;
    }

    public function set property(value:String):void
    {
        removeTriggerEvent();

        _property = value;

        addTriggerEvent();
    }

    //-------------------------------------
    //  triggerEvent
    //-------------------------------------

    private var _triggerEvent:String = null;

    public function get triggerEvent():String
    {
        if (_triggerEvent == null)
        {
            if (_property != null)
            {
                return _property + "Changed";
            }
        }

        return _triggerEvent;
    }

    public function set triggerEvent(value:String):void
    {
        removeTriggerEvent();

        _triggerEvent = value;

        addTriggerEvent();
    }

    //-------------------------------------
    //  required
    //-------------------------------------

    private var _required:Boolean = true;

    public function get required():Boolean
    {
        return _required;
    }

    public function set required(value:Boolean):void
    {
        _required = value;
    }

    //-------------------------------------
    //  silence
    //-------------------------------------

    private var _silent:Boolean = false;

    public function get silent():Boolean
    {
        return _silent;
    }

    public function set silent(value:Boolean):void
    {
        _silent = value;
    }

    //-------------------------------------
    //  requiredFieldError
    //-------------------------------------

    private var _requiredFieldError:String = "This is a required field.";

    public function get requiredFieldError():String
    {
        return _requiredFieldError;
    }

    public function set requiredFieldError(value:String):void
    {
        _requiredFieldError = value;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function validate(value:Object = null, silentValidation:Boolean = false):ValidationEvent
    {
        value = value || getValueFormSource();

        var event:ValidationEvent;

        if (required)
        {
            var results:Array = doValidation(value);

            if (results && results.length > 0)
                event = new ValidationEvent(ValidationEvent.INVALID, results);
            else
                event = new ValidationEvent(ValidationEvent.VALID);
        }
        else
        {
            event = new ValidationEvent(ValidationEvent.VALID);
        }

        if (!silentValidation || event.type == ValidationEvent.VALID)
            dispatchEvent(event);

        return event;
    }

    protected function doValidation(value:Object):Array
    {
        var results:Array = [];

        var result:ValidationResult = validateRequiredField(value);

        if (result)
            results.push(result);

        return results;
    }

    private function validateRequiredField(value:Object):ValidationResult
    {
        if (_required)
        {
            if (!value)
            {
                return new ValidationResult(true, _requiredFieldError);
            }
        }

        return null;
    }

    //----------------------------------
    //  Methods: internal
    //----------------------------------

    private function getValueFormSource():Object
    {
        if (_source && _property)
        {
            return _source[_property];
        }

        return null;
    }

    //----------------------------------
    //  Methods: trigger
    //----------------------------------

    private function addTriggerEvent():void
    {
        var trigger:Object = _source;

        if (trigger && triggerEvent)
        {
            trigger.addEventListener(triggerEvent, triggerHandler);
        }
    }

    private function removeTriggerEvent():void
    {
        var trigger:Object = _source;

        if (trigger && triggerEvent)
        {
            trigger.removeEventListener(triggerEvent, triggerHandler);
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Event Handlers
    //
    //--------------------------------------------------------------------------

    private function triggerHandler(event:Object):void
    {
        validate(null, _silent);
    }


}
}
