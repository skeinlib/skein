/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/24/13
 * Time: 10:50 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.states
{
public class State
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function State(name:String)
    {
        super();

        this._name = name;
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  overrides
    //------------------------------------

    private var _overrides:Vector.<Override> = new <Override>[];

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  name
    //------------------------------------

    private var _name:String = null;

    public function get name():String
    {
        return _name;
    }

    //------------------------------------
    //  base
    //------------------------------------

    private var _base:State;

    public function get base():State
    {
        return _base;
    }

    public function set base(value:State):void
    {
        _base = value;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  Methods: Overrides
    //------------------------------------

    public function numOverrides():uint
    {
        return _overrides.length;
    }

    public function getOverrideAt(index:uint):Override
    {
        if (index >= _overrides.length)
            return null;

        return _overrides[index];
    }

    public function addOverride(value:Override):void
    {
        value.setState(this);

        _overrides.push(value);
    }

    public function removeOverride(value:Override):void
    {
        removeOverrideAt(_overrides.indexOf(value));
    }

    public function removeOverrideAt(index:uint):void
    {
        _overrides.splice(index, 1);
    }
}
}
