/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/25/13
 * Time: 2:03 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.states.overrides
{
public class AddChild extends OverrideBase
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function AddChild(property:String, name:String, value:Object)
    {
        super(property, name, value);
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------



    //--------------------------------------------------------------------------
    //
    //  Overridden Methods
    //
    //--------------------------------------------------------------------------

    override public function apply(host:Object):void
    {
        this.applied = true;
    }

    override public function remove(host:Object):void
    {
        this.applied = false;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

}
}
