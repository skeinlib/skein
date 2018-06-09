/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 12/27/13
 * Time: 10:01 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes.core
{
import flash.events.Event;

import skein.tubes.tube.Tube;

public class TubeRegistry
{
    protected static const tubes:Object = {};

    public static function get(name:String):Tube
    {
        if (name in tubes)
            return tubes[name];

        var tube:Tube = tubes[name] = new Tube(name);
        tube.addEventListener(Event.CLOSE,
            function handler(event:Event):void
            {
                tube.removeEventListener(Event.CLOSE, handler);

                tubes[tube.name] = null;
                delete tubes[tube.name];
            });

        return tube;
    }
}
}
