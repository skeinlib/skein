/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/1/14
 * Time: 12:17 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.validators.validators
{
import skein.validators.data.ValidationResult;

public class EqualValidator extends BasicValidator
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function EqualValidator()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------------
    //  mismatchError
    //----------------------------------------

    private var _mismatchError:String = "The entered value is mismatched with expected.";
    public function get mismatchError():String {
        return _mismatchError;
    }
    public function set mismatchError(value:String):void {
        _mismatchError = value;
    }

    //----------------------------------------
    //  expectedValue
    //----------------------------------------

    private var _expectedValue:Object;
    public function get expectedValue():Object {
        return _expectedValue;
    }
    public function set expectedValue(value:Object):void {
        _expectedValue = value;
    }

    //----------------------------------------
    //  expectedProperty
    //----------------------------------------

    private var _expectedProperty: String;
    public function get expectedProperty(): String {
        return _expectedProperty;
    }
    public function set expectedProperty(value: String): void {
        _expectedProperty = value;
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override protected function doValidation(value:Object):Array
    {
        var results:Array = super.doValidation(value);

        if (results.length > 0) {
            return results;
        } else {
            return validateEquals(value);
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    private function getExpectedValue(): Object {
        if (_expectedValue) {
            return _expectedValue;
        }

        if (_expectedProperty && source.hasOwnProperty(_expectedProperty)) {
            return source[_expectedProperty];
        }

        return null;
    }

    private function validateEquals(value:Object):Array
    {
        var results:Array = [];

        if (required)
        {
            if (value != getExpectedValue())
                results.push(new ValidationResult(true, mismatchError))
        }

        return results;
    }
}
}
