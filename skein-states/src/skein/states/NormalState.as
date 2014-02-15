/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/30/13
 * Time: 11:15 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.states
{
public class NormalState extends State
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function NormalState()
    {
        super("");
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden properties
    //
    //--------------------------------------------------------------------------

    override public final function get base():State
    {
        return null;
    }

    override public final function set base(value:State):void
    {
        // normal state can't have base state
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override public final function numOverrides():uint
    {
        // normal state can't have overrides

        return 0;
    }

    override public final function addOverride(value:Override):void
    {
        // normal state can't have overrides
    }

    override public final function getOverrideAt(index:uint):Override
    {
        // normal state can't have overrides

        return null;
    }

    override public final function removeOverride(value:Override):void
    {
        // normal state can't have overrides
    }

    override public final function removeOverrideAt(index:uint):void
    {
        // normal state can't have overrides
    }
}
}
