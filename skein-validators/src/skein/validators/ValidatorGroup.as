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
import skein.validators.events.ValidatorGroupEvent;

public class ValidatorGroup extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function ValidatorGroup() {
        super();
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

    [Bindable(event="validationChange")]
    public function get isValid():Boolean {
        return !invalid || invalid.length == 0;
    }

    //-------------------------------------
    //  enabled
    //-------------------------------------

    private var _enabled:Boolean = true;
    [Bindable(event="enabledChanged")]
    public function get enabled():Boolean {
        return _enabled;
    }
    public function set enabled(value:Boolean):void {
        if (_enabled == value) return;
        _enabled = value;
        dispatchEvent(new Event("enabledChanged"));
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function addValidator(validator:Validator):void {
        if (validator != null) {
            validator.addEventListener(ValidationEvent.VALID, validator_validHandler);
            validator.addEventListener(ValidationEvent.INVALID, validator_invalidHandler);

            validators.push(validator);
        }
    }

    public function validate(silentValidation:Boolean=false):Boolean {
        clearInvalids();

        if (enabled) {
            doValidate(silentValidation);
        }

        return isValid;
    }

    public function reset():void {
        invalid.length = 0;

        for each (var validator:Validator in validators) {
            validator.dispatchEvent(new ValidationEvent(ValidationEvent.VALID));
        }
    }

    private function doValidate(silentValidation:Boolean):void {
        for each (var validator:Validator in validators) {
            var result:ValidationEvent = validator.validate(null, silentValidation);
        }
    }

    private function addInvalid(validator:Validator):void {
        if (invalid.indexOf(validator) == -1) {
            invalid.push(validator);
            dispatchEvent(new ValidatorGroupEvent(ValidatorGroupEvent.VALIDATION_CHANGE, isValid));
        }
    }

    private function removeInvalid(validator:Validator):void {
        var index:int = invalid.indexOf(validator);
        if (index != -1) {
            invalid.splice(index, 1);
            dispatchEvent(new ValidatorGroupEvent(ValidatorGroupEvent.VALIDATION_CHANGE, isValid));
        }
    }

    private function clearInvalids(): void {
        if (invalid.length > 0) {
            invalid.length = 0;
            dispatchEvent(new ValidatorGroupEvent(ValidatorGroupEvent.VALIDATION_CHANGE, isValid));
        }
    }

    // Event handlers

    private function validator_validHandler(event: Event): void {
        removeInvalid(event.target as Validator);
    }

    private function validator_invalidHandler(event: Event): void {
        addInvalid(event.target as Validator);
    }
}
}
