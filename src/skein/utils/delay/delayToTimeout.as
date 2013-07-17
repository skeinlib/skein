package skein.utils.delay
{
import flash.events.TimerEvent;
import flash.utils.Timer;

public function delayToTimeout(timeout:uint, callback:Function, ...args):void
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
}