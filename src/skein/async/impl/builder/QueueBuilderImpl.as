/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/16/13
 * Time: 9:51 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.async.impl.builder
{
import flash.events.ErrorEvent;
import flash.events.Event;

import skein.async.Queue;
import skein.async.builder.QueueBuilder;

public class QueueBuilderImpl implements QueueBuilder
{
    public function QueueBuilderImpl()
    {
        super();
    }

    private var maxThreadsForFrame:uint;

    public function threads(maxThreadsForFrame:uint):QueueBuilder
    {
        return this;
    }

    private var maxTimeForFrame:uint;

    public function time(maxTimeForFrame:uint):QueueBuilder
    {
        return this;
    }

    private var tasks:Array = [];

    public function add(tasks:Object):QueueBuilder
    {
        this.tasks = this.tasks.concat(tasks);

        return this;
    }

    private var completeHandler:Function;

    public function complete(handler:Function):QueueBuilder
    {
        this.completeHandler = handler;

        return this;
    }

    private var errorHandler:Function;

    public function error(handler:Function):QueueBuilder
    {
        this.errorHandler = handler;

        return this;
    }

    public function build():Queue
    {
        var queue:Queue = new Queue(tasks);

        if (maxThreadsForFrame != 0)
            queue.setMaxThreadsForFrame(maxThreadsForFrame);

        if (maxTimeForFrame != 0)
            queue.setMaxTimeForFrame(maxTimeForFrame);

        if (completeHandler != null)
            queue.addEventListener(Event.COMPLETE, completeHandler);

        if (errorHandler != null)
            queue.addEventListener(ErrorEvent.ERROR, errorHandler);

        return queue;
    }
}
}
