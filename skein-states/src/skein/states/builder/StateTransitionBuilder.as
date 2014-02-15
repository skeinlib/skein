/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 5:34 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.states.builder
{
import skein.states.builder.group.ParallelBuilder;
import skein.states.builder.group.SequenceBuilder;

public interface StateTransitionBuilder
{
    function from(state:String):StateTransitionBuilder;

    function to(state:String):StateTransitionBuilder;

    function sequence():SequenceBuilder;

    function parallel():ParallelBuilder;

    function error(handler:Function):StateTransitionBuilder;

    function complete(handler:Function):StateTransitionBuilder;
}
}
