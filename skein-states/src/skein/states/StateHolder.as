/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 5:09 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.states
{
import skein.states.builder.StateBuilder;
import skein.states.transition.StateTransition;

public interface StateHolder
{
    function getCurrentState():State;

    function state(name:String):StateBuilder;

    function go(state:String):StateTransition;

    function normal():StateTransition;
}
}
