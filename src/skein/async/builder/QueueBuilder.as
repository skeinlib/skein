/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/15/13
 * Time: 10:50 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.async.builder
{
import skein.async.Queue;

public interface QueueBuilder
{
    function threads(maxThreadsForFrame:uint):QueueBuilder;

    function time(maxTimeForFrame:uint):QueueBuilder;

    function add(tasks:Object):QueueBuilder;

    function complete(completeHandler:Function):QueueBuilder;

    function error(errorHandler:Function):QueueBuilder;

    function build():Queue;
}
}
