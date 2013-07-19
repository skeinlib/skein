/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/18/13
 * Time: 10:49 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.validation.events
{
import flash.events.Event;

public class ValidationEvent extends Event
{
    public static const VALID:String    = "valid";

    public static const INVALID:String  = "invalid";

    public function ValidationEvent(type:String, results:Array=null, bubbles:Boolean = false, cancelable:Boolean = false)
    {
        super(type, bubbles, cancelable);

        this._results = results;
    }

    private var _results:Array;

    public function get results():Array
    {
        return _results;
    }
}
}
