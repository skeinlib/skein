/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/17/13
 * Time: 4:38 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.validation
{
import flash.events.Event;
import flash.events.EventDispatcher;

import skein.validation.core.ValidatorProxy;
import skein.validation.events.ValidationEvent;

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

    private var validators:Array = [];

    private var invalid:Array;

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

    private var _enabled:Boolean;

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

    public function validate(silent:Boolean):Boolean
    {
        invalid.length = 0;

        if (enabled)
        {
            doValidate(silent);
        }

        return isValid;
    }

    private function doValidate(silent:Boolean):void
    {
        for each (var validator:Validator in validators)
        {
//            var result:ValidationEvent = ValidatorProxy.validate(validator);

//            if (result && result.)
        }
    }

    private function addInvalid(validator:Object):void
    {
        if (invalid.indexOf(validator) != -1)
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
