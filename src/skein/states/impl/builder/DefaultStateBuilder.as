/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/24/13
 * Time: 11:04 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.states.impl.builder
{
import skein.core.skein_internal;
import skein.states.State;
import skein.states.StateHolder;
import skein.states.builder.StateBuilder;
import skein.states.builder.StateOverrideBuilder;
import skein.states.core.StateGlobals;

use namespace skein_internal;

public class DefaultStateBuilder implements StateBuilder
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function DefaultStateBuilder(builder:StateHolder, host:Object, name:String)
    {
        super();

        this.builder = builder;

        this.host = host;

        this.state = new State(name);

        StateGlobals.addState(this.host, this.state);
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    protected var builder:StateHolder;

    protected var host:Object;

    protected var state:State;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function base(state:String):StateBuilder
    {
        this.state.base = StateGlobals.getState(this.host, state);

        return this;
    }

    public function part(id:Object):StateOverrideBuilder
    {
        return new DefaultStateOverrideBuilder(this, this.state, id);
    }

    public function add(id:Object, instance:Object):StateOverrideBuilder
    {
        return null;
    }

    public function remove(id:Object):StateOverrideBuilder
    {
        return null;
    }

    public function build():StateHolder
    {
        return this.builder;
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

}
}
