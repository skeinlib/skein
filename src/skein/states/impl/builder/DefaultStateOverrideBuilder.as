/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/24/13
 * Time: 11:09 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.states.impl.builder
{
import skein.core.skein_internal;
import skein.states.State;
import skein.states.builder.StateBuilder;
import skein.states.builder.StateOverrideBuilder;
import skein.states.core.StateGlobals;
import skein.states.overrides.SetHandler;
import skein.states.overrides.SetProperty;

use namespace skein_internal;

public class DefaultStateOverrideBuilder implements StateOverrideBuilder
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function DefaultStateOverrideBuilder(parent:DefaultStateBuilder, state:State, part:Object)
    {
        super();

        this.parent = parent;

        this.state = state;

        this.part = part as String;
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    protected var parent:DefaultStateBuilder;

    protected var state:State;

    protected var part:String;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function set(property:String, value:Object):StateOverrideBuilder
    {
        this.state.addOverride(new SetProperty(this.part, property, value));

        return this;
    }

    public function call(method:String, arguments:Array):StateOverrideBuilder
    {
        return this;
    }

    public function move(x:Object, y:Object):StateOverrideBuilder
    {
        this.x(x);
        this.y(y);

        return this;
    }

    public function x(x:Object):StateOverrideBuilder
    {
        this.set("x", x);

        return this;
    }

    public function y(y:Object):StateOverrideBuilder
    {
        this.set("y", y);

        return this;
    }

    public function size(w:Object, h:Object):StateOverrideBuilder
    {
        this.width(w);
        this.height(h);

        return this;
    }

    public function width(value:Object):StateOverrideBuilder
    {
        this.set("width", value);

        return this;
    }

    public function height(value:Object):StateOverrideBuilder
    {
        this.set("height", value);

        return this;
    }

    public function enable():StateOverrideBuilder
    {
        this.set("enabled", true);

        return this;
    }

    public function disable():StateOverrideBuilder
    {
        this.set("enabled", false);

        return this;
    }

    public function left(value:Object):StateOverrideBuilder
    {
        this.set("left", value);

        return this;
    }

    public function top(value:Object):StateOverrideBuilder
    {
        this.set("top", value);

        return this;
    }

    public function right(value:Object):StateOverrideBuilder
    {
        this.set("right", value);

        return this;
    }

    public function bottom(value:Object):StateOverrideBuilder
    {
        this.set("bottom", value);

        return this;
    }

    public function horizontalCenter(value:Object):StateOverrideBuilder
    {
        this.set("horizontalCenter", value);

        return this;
    }

    public function verticalCenter(value:Object):StateOverrideBuilder
    {
        this.set("verticalCenter", value);

        return null;
    }

    public function includeInLayout(value:Object):StateOverrideBuilder
    {
        this.set("includeInLayout", value);

        return this;
    }

    public function on(event:String, handler:Function):StateOverrideBuilder
    {
        StateGlobals.putHandler(this.state, this.part as String, event, handler);

        var o:SetHandler = new SetHandler(this.part, event, null);

        this.state.addOverride(o);

        return this;
    }

    public function removeHandler(event:String, handler:Function):StateOverrideBuilder
    {
        return this;
    }

    public function end():StateBuilder
    {
        return this.parent;
    }
}
}
