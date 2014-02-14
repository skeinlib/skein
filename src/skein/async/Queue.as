/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/10/13
 * Time: 7:53 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.async
{
import flash.display.Sprite;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.getTimer;

[Event(name="complete", type="flash.events.Event")]
[Event(name="error", type="flash.events.ErrorEvent")]
public class Queue extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Queue(tasks:Array)
    {
        super();

        this.tasks = tasks;
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Variables: Tasks
    //-------------------------------------

    private var tasks:Array;

    //-------------------------------------
    //  Variables: Flags
    //-------------------------------------

    private var busy:Boolean = false;
    private var ready:Boolean = false;

    //-------------------------------------
    //  Variables: Sprite dispatcher
    //-------------------------------------

    private var enterFrameDispatcher:Sprite;

    //-------------------------------------
    //  Variables: Frame
    //-------------------------------------

    private var frameCurrentThread:uint = 0;

    private var frameStartTime:int = -1;

    private var frameElapsedTime:int = 0;

    //--------------------------------------------------------------------------
    //
    //  Setters
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  maxThreadsForFrame
    //-------------------------------------

    private var maxThreadForFrame:uint = 4;

    public function setMaxThreadsForFrame(value:uint):void
    {
        this.maxThreadForFrame = value;
    }

    //-------------------------------------
    //  maxTimePerFrame
    //-------------------------------------

    private var maxTimeForFrame:uint = 200;

    public function setMaxTimeForFrame(value:uint):void
    {
        this.maxTimeForFrame = value;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Methods: Public API
    //-------------------------------------

    public function add(...params:Array):void
    {
        if (params != null)
        {
            tasks = tasks.concat(params);
        }
    }

    public function start():void
    {
        enterFrameDispatcher = new Sprite();
        enterFrameDispatcher.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
    }

    public function stop():void
    {
        enterFrameDispatcher.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
        enterFrameDispatcher = null;

        busy = false;
        ready = false;
    }

    //-------------------------------------
    //  Methods: Public API
    //-------------------------------------

    protected function tick():void
    {
        if (busy) return;

        var task:Object = tasks.shift();

        if (task is Function)
        {
            task.apply(null, [callback]);
        }
        else if (task.hasOwnProperty("perform"))
        {
            if (task.hasOwnProperty("callback"))
            {
                task.callback = callback;
                task.perform();
            }
            else
            {
                try
                {
                    callback(task.perform());
                }
                catch (error:Error)
                {
                    callback(error);
                }
            }
        }
    }

    protected function callback(info:Object):void
    {
        if (info is Error)
        {
            stop();

            dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, Error(info).message));
        }
        else if (tasks.length == 0)
        {
            stop();

            dispatchEvent(new Event(Event.COMPLETE));
        }
        else
        {
            busy = false;

            frameCurrentThread++;

            frameElapsedTime += (getTimer() - frameStartTime);

            if (frameCurrentThread == maxThreadForFrame || frameElapsedTime >= maxTimeForFrame)
            {
                frameCurrentThread = 0;
                frameElapsedTime = 0;
                // wait for next frame
            }
            else
            {
                tick();
            }
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //--------------------------------------------------------------------------

    private function enterFrameHandler(event:Event):void
    {
        if (busy) return;

        if (ready)
        {
            ready = false;

            frameCurrentThread = 0;

            frameStartTime = getTimer();

            tick();
        }
        else
        {
            ready = true;
        }
    }
}
}
