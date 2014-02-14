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
        super(type, bubbles);

        _data = data;
    }

    private var _data:Object;
    public function get data():Object
    {
        return _data;
    }

    override public function clone():Event
    {
        return new PopupEvent(type, bubbles, data);
    }
}
}
