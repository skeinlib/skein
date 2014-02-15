/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/24/13
 * Time: 3:56 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.states.overrides
{
import flash.utils.Dictionary;

import skein.core.skein_internal;
import skein.states.core.StateGlobals;
import skein.core.WeakReference;

use namespace skein_internal;

public class SetHandler extends OverrideBase
{
    //--------------------------------------------------------------------------
    //
    //  Class variables
    //
    //--------------------------------------------------------------------------

    private static var addedHandlers:Dictionary;

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function SetHandler(property:String, name:String, value:Object, weak:Boolean=false)
    {
        super(property, name, null);

        this._value = new WeakReference(value);

        this.weak = weak;
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    protected var weak:Boolean;

    protected var oldHandler:Function;

    protected var newHandler:Function;

    //--------------------------------------------------------------------------
    //
    //  Overridden properties
    //
    //--------------------------------------------------------------------------

//    private var _value:WeakReference;

    override public function get value():Object
    {
        return _value.value;
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden Methods
    //
    //--------------------------------------------------------------------------

    override public function apply(host:Object):void
    {
        var target:Object = this.getContext(host);

        if (!this.applied)
        {
            var handler:Function = StateGlobals.getHandler(this.state, this.property, this.name);

            if (handler)
            {
                this.addTargetListener(target, handler);
            }
        }

        this.applied = true;
    }

    override public function remove(host:Object):void
    {
        var target:Object = this.getContext(host);

        if (this.applied)
        {
            var handler:Function = StateGlobals.getHandler(this.state, this.property, this.name);

            if (handler)
            {
                this.removeTargetListener(target, handler);
            }
        }

        this.applied = false;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    protected function addTargetListener(target:Object, handler:Function):void
    {
        target.addEventListener(this.name, handler, false, 0, this.weak);
    }

    protected function removeTargetListener(target:Object, handler:Function):void
    {
        target.removeEventListener(this.name, handler);
    }
}
}
