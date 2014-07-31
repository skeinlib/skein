/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/17/13
 * Time: 4:38 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.validators
{
import flash.events.Event;
import flash.events.EventDispatcher;

import skein.validators.core.ValidatorProxy;
import skein.validators.events.ValidationEvent;

public class ValidatorGroup extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function ValidatorGroup()
    {
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    public var validators:Array = [];

    private var invalid:Array = [];

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  isValid
    //-------------------------------------

    public function get isValid():Boolean
    {
        return !invalid || invalid.length == 0;
    }

    //-------------------------------------
    //  enabled
    //-------------------------------------

    private var _enabled:Boolean = true;

    [Bindable(event="enabledChanged")]
    public function get enabled():Boolean
    {
        return _enabled;
    }

    public function set enabled(value:Boolean):void
    {
        if (_enabled == value) return;
        _enabled = value;
        dispatchEvent(new Event("enabledChanged"));
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    protected function addValidator(validator:Object):void
    {
        if (validator != null)
        {
            validators.push(validator);
        }
    }

    public function validate(silentValidation:Boolean=false):Boolean
    {
        invalid.length = 0;

        if (enabled)
        {
            doValidate(silentValidation);
        }

        return isValid;
    }

    private function doValidate(silentValidation:Boolean):void
    {
        for each (var validator:Validator in validators)
        {
            var result:ValidationEvent = validator.validate(null, silentValidation);

            if (result.results && result.results.length > 0)
            {
                addInvalid(validator);
            }
        }
    }

    private function addInvalid(validator:Object):void
    {
        if (invalid.indexOf(validator) == -1)
        {
            invalid.push(validator);

            // TODO: dispatch validity change
        }
    }

    private function removeInvalid(validator:Object):void
    {
        var index:int = invalid.indexOf(validator);

        if (index != -1)
        {
            invalid.splice(index, 1);

            // TODO: dispatch validity change
        }
    }
}
}
