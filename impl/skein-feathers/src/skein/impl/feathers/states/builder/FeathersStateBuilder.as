/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/24/13
 * Time: 11:04 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.states.builder
{
import skein.states.StateHolder;
import skein.states.builder.StateBuilder;
import skein.states.builder.StateOverrideBuilder;
import skein.states.impl.builder.DefaultStateBuilder;

public class FeathersStateBuilder extends DefaultStateBuilder implements StateBuilder
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function FeathersStateBuilder(parent:StateHolder, host:Object, name:String)
    {
        super(parent, host, name);
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override public function part(id:Object):StateOverrideBuilder
    {
        return new FeathersStateOverrideBuilder(this, this.state, id);
    }
}
}
