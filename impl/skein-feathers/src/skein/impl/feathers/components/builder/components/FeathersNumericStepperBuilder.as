/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/16/13
 * Time: 6:02 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.components
{
import feathers.controls.NumericStepper;

import skein.components.builder.components.NumericStepperBuilder;
import skein.components.builder.mixins.ComponentMixin;
import skein.components.builder.mixins.EventDispatcherMixin;
import skein.components.builder.mixins.LayoutElementMixin;
import skein.components.builder.mixins.SpriteMixin;
import skein.core.PropertySetter;
import skein.impl.feathers.components.builder.FeathersBuilder;
import skein.impl.feathers.components.builder.mixins.FeathersComponentNature;
import skein.impl.feathers.components.builder.mixins.FeathersEventDispatcherNature;
import skein.impl.feathers.components.builder.mixins.FeathersLayoutElementNature;
import skein.impl.feathers.components.builder.mixins.FeathersSpriteNature;

public class FeathersNumericStepperBuilder extends FeathersBuilder implements NumericStepperBuilder
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function FeathersNumericStepperBuilder(host:Object)
    {
        super();

        this.host = host;
        this._instance = new NumericStepper();

        this.spriteMixin = new FeathersSpriteNature(this.instance);
        this.componentMixin = new FeathersComponentNature(this.instance);
        this.layoutElementMixin = new FeathersLayoutElementNature(this.instance);
        this.eventDispatcherMixin = new FeathersEventDispatcherNature(this.instance);
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Variables: Mixins
    //-------------------------------------

    private var spriteMixin:SpriteMixin;

    private var componentMixin:ComponentMixin;

    private var layoutElementMixin:LayoutElementMixin;

    private var eventDispatcherMixin:EventDispatcherMixin;

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  instance
    //-------------------------------------

    private function get instance():NumericStepper
    {
        return _instance as NumericStepper;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  Methods: Sprite
    //------------------------------------

    public function x(value:Object):NumericStepperBuilder
    {
        spriteMixin.x(value);

        return this;
    }

    public function y(value:Object):NumericStepperBuilder
    {
        spriteMixin.y(value);

        return this;
    }

    public function width(value:Object):NumericStepperBuilder
    {
        spriteMixin.width(value);

        return this;
    }

    public function height(value:Object):NumericStepperBuilder
    {
        spriteMixin.height(value);

        return this;
    }

    public function rotation(value:Object, axis:String = null):NumericStepperBuilder
    {
        spriteMixin.rotation(value, axis);

        return this;
    }

    public function visible(value:Object):NumericStepperBuilder
    {
        spriteMixin.visible(value);

        return this;
    }

    public function alpha(value:Object):NumericStepperBuilder
    {
        spriteMixin.alpha(value);

        return this;
    }

    public function z(value:Object):NumericStepperBuilder
    {
        spriteMixin.z(value);

        return this;
    }

    public function scale(value:Object, axis:String = null):NumericStepperBuilder
    {
        spriteMixin.scale(value, axis);

        return this;
    }

    public function mask(value:Object):NumericStepperBuilder
    {
        spriteMixin.mask(value);

        return this;
    }

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    public function on(type:String, handler:Function, weak:Boolean = true):NumericStepperBuilder
    {
        eventDispatcherMixin.on(type, handler, weak);

        return this;
    }

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    public function left(value:Object):NumericStepperBuilder
    {
        layoutElementMixin.left(value);

        return this;
    }

    public function top(value:Object):NumericStepperBuilder
    {
        layoutElementMixin.top(value);

        return this;
    }

    public function right(value:Object):NumericStepperBuilder
    {
        layoutElementMixin.right(value);

        return this;
    }

    public function bottom(value:Object):NumericStepperBuilder
    {
        layoutElementMixin.bottom(value);

        return this;
    }

    public function horizontalCenter(value:Object):NumericStepperBuilder
    {
        layoutElementMixin.horizontalCenter(value);

        return this;
    }

    public function verticalCenter(value:Object):NumericStepperBuilder
    {
        layoutElementMixin.verticalCenter(value);

        return this;
    }

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    public function id(id:Object):NumericStepperBuilder
    {
        this.instanceId = id;

        return this;
    }

    public function styleName(value:Object):NumericStepperBuilder
    {
        componentMixin.styleName(value);

        return this;
    }

    public function enabled(value:Object):NumericStepperBuilder
    {
        componentMixin.enabled(value);

        return this;
    }

    //-----------------------------------
    //  Methods: textInput
    //-----------------------------------

    public function minimum(value:Object):NumericStepperBuilder
    {
        PropertySetter.set(this.instance, "minimum", value);

        return this;
    }

    public function maximum(value:Object):NumericStepperBuilder
    {
        PropertySetter.set(this.instance, "maximum", value);

        return this;
    }

    public function step(value:Object):NumericStepperBuilder
    {
        PropertySetter.set(this.instance, "step", value);

        return this;
    }

    public function value(value:Object):NumericStepperBuilder
    {
        PropertySetter.set(this.instance, "value", value);

        return this;
    }
}
}
