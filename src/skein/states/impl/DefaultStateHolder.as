/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 5:47 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.states.impl
{
import skein.core.skein_internal;
import skein.states.NormalState;
import skein.states.State;
import skein.states.StateHolder;
import skein.states.builder.StateBuilder;
import skein.states.core.StateGlobals;
import skein.states.impl.builder.DefaultStateBuilder;
import skein.states.transition.StateTransition;

use namespace skein_internal;

public class DefaultStateHolder implements StateHolder
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function DefaultStateHolder(host:Object)
    {
        super();

        this.host = host;
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    protected var host:Object;

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    public function getCurrentState():State
    {
        return StateGlobals.getCurrentState(this.host) || new NormalState();
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function state(name:String):StateBuilder
    {
        return new DefaultStateBuilder(this, this.host, name);
    }

    public function go(state:String):StateTransition
    {
        const from:State = this.getCurrentState();

        const to:State = StateGlobals.getState(this.host, state);

        if (to)
        {
            var t:StateTransition = new StateTransition(this.host, from, to);

            t.perform();

            StateGlobals.setCurrentState(this.host, to);
        }

        return t;
    }

    public function normal():StateTransition
    {
        var from:State = this.getCurrentState();

        var to:State = new NormalState();

        var t:StateTransition = new StateTransition(this.host, from, to);

        t.perform();

        StateGlobals.setCurrentState(this.host, null);

        return t;
    }
}
}
