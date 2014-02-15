/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/19/13
 * Time: 10:10 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.validators.validators
{
import skein.validators.data.ValidationResult;

public class PhoneValidator extends BasicValidator
{
    private static const PHONE_REGEXP:RegExp = /^[\+0-9]+$/;

    public function PhoneValidator()
    {
        super();
    }

    private var _phoneWrongFormatError:String = 'Valid format is "+123456789"';

    public function get phoneWrongFormatError():String
    {
        return _phoneWrongFormatError;
    }

    public function set phoneWrongFormatError(value:String):void
    {
        _phoneWrongFormatError = value;
    }

    override protected function doValidation(value:Object):Array
    {
        var result:Array = super.doValidation(value);

        if (result.length > 0)
            return result;
        else
            return validatePhone(value);
    }

    private function validatePhone(value:Object):Array
    {
        var results:Array = [];

        if (required)
        {
            if (!PHONE_REGEXP.test(String(value)))
            {
                results.push(new ValidationResult(true, _phoneWrongFormatError));
            }
        }

        return results;
    }
}
}
