/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/18/13
 * Time: 11:24 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.validators.data
{
public class ValidationResult
{
    public function ValidationResult(isError:Boolean, errorMessage:String)
    {
        super();

        this.isError = isError;
        this.errorMessage = errorMessage;
    }

    public var isError:Boolean;

    public var errorMessage:String;
}
}
