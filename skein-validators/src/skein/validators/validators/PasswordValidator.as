/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/18/13
 * Time: 2:05 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.validators.validators
{
import skein.validators.data.ValidationResult;

public class PasswordValidator extends BasicValidator {

    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

//    private static const PASSWORD_REGEXP:RegExp = /((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{6,20})/;
    private static const PASSWORD_REGEXP:RegExp = /(?!^[0-9]*$)(?!^[a-zA-Z!@#$%^&amp;*()_+=<&gt;?]*$)^([a-zA-Z!@#$%^&amp;*()_+=<&gt;?0-9]{6,15})$/;

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function PasswordValidator() {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  passwordRegexp
    //-------------------------------------

    private var _passwordRegexp: RegExp;
    public function get passwordRegexp(): RegExp {
        return _passwordRegexp;
    }
    public function set passwordRegexp(value: RegExp): void {
        _passwordRegexp = value;
    }

    //-------------------------------------
    //  passwordToWeakError
    //-------------------------------------

    private var _passwordToWeakError:String = "Password is too weak.";
    public function get passwordToWeakError():String {
        return _passwordToWeakError;
    }
    public function set passwordToWeakError(value:String):void {
        _passwordToWeakError = value;
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override protected function doValidation(value:Object):Array {
        var result:Array = super.doValidation(value);

        if (result.length > 0)
            return result;
        else
            return validatePassword(value);
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    private function validatePassword(value:Object):Array {
        var results:Array = [];

        if (required) {
            var pattern:RegExp = _passwordRegexp || PASSWORD_REGEXP;
            if (!pattern.test(String(value))) {
                results.push(new ValidationResult(true, _passwordToWeakError));
            }
        }

        return results;
    }
}
}
