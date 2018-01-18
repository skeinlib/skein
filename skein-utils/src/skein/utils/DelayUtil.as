/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/23/13
 * Time: 6:23 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.utils
{
import flash.display.Shape;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Dictionary;
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

    private static var timeouts: Vector.<Function> = new <Function>[];
    private static function nextTimeoutId(): int {
        for (var i: int = 0, n:int = timeouts.length; i < n; i++) {
            if (timeouts[i] == null) {
                return i;
            }
        }
        return timeouts.length;
    }

    public static function delayToTimeout(timeout:uint, callback:Function, ...args): int
    {
        var timeoutId: int = nextTimeoutId();

        var release: Function = function(): void {
            timer.removeEventListener(TimerEvent.TIMER_COMPLETE, handler);
            if (timer.running) {
                timer.stop();
            }
        };

        timeouts[timeoutId] = release;

        var handler: Function = function (e: Object) {
            releaseTimeout(timeoutId);
            callback.apply(null, args);
        };

        var timer:Timer = new Timer(timeout, 1);
        timer.addEventListener(TimerEvent.TIMER_COMPLETE, handler);
        timer.start();

        return timeoutId;
    }

    public static function releaseTimeout(id: int): void {
        var release: Function = timeouts[id];
        if (release != null) {
            release();
            timeouts[id] = null;
        }
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

    // callLater

    private static var _callLaterDisplayObject:Shape;
    private static var _callLaterIsListeningForRender:Boolean;

    private static var _callLaterQueue:Vector.<Function> = new <Function>[];
    private static var _callLaterDict:Dictionary = new Dictionary(true);

    public static function callLater(callback:Function):void
    {
        if (callback == null)
            return;

        if (_callLaterDict[callback])
            return;

        _callLaterQueue[_callLaterQueue.length] = callback;
        _callLaterDict[callback] = true;

        if (_callLaterDisplayObject == null)
            _callLaterDisplayObject = new Shape();

        if (!_callLaterIsListeningForRender)
        {
            _callLaterIsListeningForRender = true;
            _callLaterDisplayObject.addEventListener(Event.ENTER_FRAME, _callLaterDisplayObjectRenderHandler);
        }
    }

    private static function _callLaterDisplayObjectRenderHandler(event:Event):void
    {
        _callLaterDisplayObject.removeEventListener(Event.ENTER_FRAME, _callLaterDisplayObjectRenderHandler);
        _callLaterIsListeningForRender = false;

        var queue:Vector.<Function> = _callLaterQueue.concat();
        _callLaterQueue.length = 0;

        for (var i:int = 0; i < queue.length; i++)
        {
            var obj:Function = queue[i];

            queue[i].apply(null)
        }
    }
}
}

class DelayedCall
{
    function DelayedCall(method:Function, args:Array)
    {
        super();

        _method = method;
        _args = args;
    }

    private var _method:Function;
    public function get method():Function
    {
        return _method;
    }

    private var _args:Array;
    public function get args():Array
    {
        return _args;
    }
}