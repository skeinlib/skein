/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/24/13
 * Time: 11:23 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.states.overrides
{
import skein.binding.core.Source;
import skein.states.Override;
import skein.states.State;

public class OverrideBase implements Override
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function OverrideBase(property:String, name:String, value:Object)
    {
        super();

        this._property = property;

        this._name = name;
        this._value = value;
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  Variables: Flags
    //----------------------------------

    protected var applied:Boolean = false;

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-----------------------------------
    //  property
    //-----------------------------------

    private var _property:String;

    public function get property():String
    {
        return _property;
    }

    //-----------------------------------
    //  name
    //-----------------------------------

    private var _name:String;

    public function get name():String
    {
        return _name;
    }

    //-----------------------------------
    //  value
    //-----------------------------------

    protected var _value;

    public function get value():Object
    {
        if (_value is Source)
            return Source(_value).getValue();

        return _value;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  Methods: Setters
    //------------------------------------

    protected var state:State;

    public function setState(value:State):void
    {
        this.state = value;
    }

    //------------------------------------
    //  Methods: Common
    //------------------------------------

    public function equals(that:Override):Boolean
    {
        return this.property == that.property && this.name == that.name && this.value == that.value;
    }

    //------------------------------------
    //  Methods: Internal
    //------------------------------------

    protected function getContext(host:Object):Object
    {
        if (!host)
            return null;

        if (_property in host)
            return host[_property];

        return null;
    }

    //------------------------------------
    //  Methods: Abstract
    //------------------------------------

    public function apply(host:Object):void {}

    public function remove(host:Object):void {}
}
}
