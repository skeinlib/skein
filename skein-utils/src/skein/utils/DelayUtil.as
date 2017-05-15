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