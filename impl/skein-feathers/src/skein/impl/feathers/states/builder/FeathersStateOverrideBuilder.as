/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/24/13
 * Time: 11:09 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.states.builder
{
import skein.core.skein_internal;
import skein.impl.feathers.states.overrides.FeathersSetHandler;
import skein.states.Override;
import skein.states.State;
import skein.states.builder.StateOverrideBuilder;
import skein.states.core.StateGlobals;
import skein.states.impl.builder.DefaultStateOverrideBuilder;

use namespace skein_internal;

public class FeathersStateOverrideBuilder extends DefaultStateOverrideBuilder implements StateOverrideBuilder
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function FeathersStateOverrideBuilder(parent:FeathersStateBuilder, state:State, part:Object)
    {
        super(parent, state, part);
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override public function enable():StateOverrideBuilder
    {
        this.set("isEnabled", true);

        return this;
    }

    override public function disable():StateOverrideBuilder
    {
        this.set("isEnabled", false);

        return this;
    }

    override public function on(event:String, handler:Function):StateOverrideBuilder
    {
        StateGlobals.putHandler(this.state, this.part as String, event, handler);

        var o:Override = new FeathersSetHandler(this.part, event, null);

        this.state.addOverride(o);

        return this;
    }
}
}
