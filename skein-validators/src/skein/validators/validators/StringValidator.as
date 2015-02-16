/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/18/13
 * Time: 11:28 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.validators.validators
{
import skein.utils.StringUtil;
import skein.validators.data.ValidationResult;

public class StringValidator extends BasicValidator
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function StringValidator()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  minLength
    //-------------------------------------

    private var _minLength:Number;

    public function get minLength():Number
    {
        return _minLength;
    }

    public function set minLength(value:Number):void
    {
        _minLength = value;
    }

    //-------------------------------------
    //  maxLength
    //-------------------------------------

    private var _maxLength:Number;

    public function get maxLength():Number
    {
        return _maxLength;
    }

    public function set maxLength(value:Number):void
    {
        _maxLength = value;
    }

    //-------------------------------------
    //  stringToShortError
    //-------------------------------------

    private var _stringToShortError:String = "The string is too short.";

    public function get stringToShortError():String
    {
        return _stringToShortError;
    }

    public function set stringToShortError(value:String):void
    {
        _stringToShortError = value;
    }

    //-------------------------------------
    //  stringToLongError
    //-------------------------------------

    private var _stringToLongError:String = "The string is to long.";

    public function get stringToLongError():String
    {
        return _stringToLongError;
    }

    public function set stringToLongError(value:String):void
    {
        _stringToLongError = value;
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override protected function doValidation(value:Object):Array
    {
        var result:Array = super.doValidation(value);

        if (result.length > 0)
            return result;
        else
            return validateString(value);
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    private function validateString(value:Object):Array
    {
        var results:Array = [];

        if (required)
        {
            var valueAsString:String = value as String;

            if (!isNaN(_minLength) && valueAsString.length < _minLength)
            {
                results.push(new ValidationResult(true, StringUtil.substitute(_stringToShortError, _minLength)));
            }

            if (!isNaN(_maxLength) && valueAsString.length > _maxLength)
            {
                results.push(new ValidationResult(true, StringUtil.substitute(_stringToLongError, _maxLength)));
            }
        }

        return results;
    }
}
}
