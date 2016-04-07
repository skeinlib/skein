/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/23/13
 * Time: 6:23 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.utils
{
import flash.events.TimerEvent;
import flash.utils.Timer;

public class DelayUtil
{
    public static function delayToEvent(dispatcher:Object, event:String, callback:Function, ...args):void
    {
        dispatcher.addEventListener(event,
                function handler(e:Object):void
                {
                    dispatcher.removeEventListener(event, handler);

                    callback.apply(null, args);
                }
        );
    }

    public static function delayToTimeout(timeout:uint, callback:Function, ...args):void
    {
        var timer:Timer = new Timer(timeout, 1);
        timer.addEventListener(TimerEvent.TIMER_COMPLETE,
                function handler(e:Object):void
                {
                    timer.removeEventListener(TimerEvent.TIMER_COMPLETE, handler);

                    callback.apply(null, args);
                }
        );
        timer.start();
    }

    private static var stretches:Array = [];

    public static function stretchToTimeout(timeout:uint, callback:Function, ...args):void
    {
        for each (var o:Object in stretches)
        {
            if (o.callback == callback)
            {
                o.args = args;
                o.timer.reset();
                o.timer.start();

                return;
            }
        }

        var timer:Timer = new Timer(timeout, 1);
        timer.addEventListener(TimerEvent.TIMER_COMPLETE,
                function handler(e:Object):void
                {
                    timer.removeEventListener(TimerEvent.TIMER_COMPLETE, arguments.callee);

                    for (var i:int = 0, n:int = stretches.length; i < n; i++)
                    {
                        var o:Object = stretches[i];

                        if (o.callback == callback)
                        {
                            stretches.splice(i, 1);

                            o.callback.apply(null, o.args);

                            break;
                        }
                    }
                }
        );
        timer.start();

        stretches.push({"callback":callback, "timer":timer, "args":args});
    }

}
}
