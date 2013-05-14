/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/25/13
 * Time: 1:48 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.states
{
import skein.impl.feathers.states.builder.FeathersStateBuilder;
import skein.states.builder.StateBuilder;
import skein.states.impl.DefaultStateHolder;

public class FeathersStateHolder extends DefaultStateHolder
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function FeathersStateHolder(host:Object)
    {
        super(host);
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override public function state(name:String):StateBuilder
    {
        return new FeathersStateBuilder(this, this.host, name);
    }
}
}
