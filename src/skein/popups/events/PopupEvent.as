/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/18/13
 * Time: 3:42 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.popups.events
{
import flash.events.Event;

public class PopupEvent extends Event
{
    public static const OPENING:String = "opening";

    public static const OPENED:String = "opened";

    public static const CLOSING:String = "closing";

    public static const CLOSED:String = "closed";

    public function PopupEvent(type:String, bubbles:Boolean = false, data:Object = null)
    {
        super(type, bubbles, data);
    }
}
}
