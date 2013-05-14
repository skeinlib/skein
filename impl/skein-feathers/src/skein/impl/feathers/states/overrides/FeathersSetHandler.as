/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/25/13
 * Time: 1:44 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.states.overrides
{
import skein.states.overrides.SetHandler;

public class FeathersSetHandler extends SetHandler
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function FeathersSetHandler(property:String, member:String, value:Object, weak:Boolean=false)
    {
        super(property, member, value, weak);
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override protected function addTargetListener(target:Object, handler:Function):void
    {
        target.addEventListener(this.name, handler);
    }

    override protected function removeTargetListener(target:Object, handler:Function):void
    {
        target.removeEventListener(this.name, handler);
    }
}
}
