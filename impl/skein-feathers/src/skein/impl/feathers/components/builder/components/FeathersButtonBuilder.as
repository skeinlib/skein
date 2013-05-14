/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/19/13
 * Time: 5:48 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.components
{
import feathers.controls.Button;

import skein.components.builder.components.ButtonBuilder;
import skein.components.builder.mixins.ComponentMixin;
import skein.components.builder.mixins.EventDispatcherMixin;
import skein.components.builder.mixins.LayoutElementMixin;
import skein.components.builder.mixins.SpriteMixin;
import skein.core.PropertySetter;
import skein.impl.feathers.components.builder.*;
import skein.impl.feathers.components.builder.mixins.FeathersComponentNature;
import skein.impl.feathers.components.builder.mixins.FeathersEventDispatcherNature;
import skein.impl.feathers.components.builder.mixins.FeathersLayoutElementNature;
import skein.impl.feathers.components.builder.mixins.FeathersSpriteNature;

public class FeathersButtonBuilder extends FeathersBuilder implements ButtonBuilder
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function FeathersButtonBuilder(host:Object)
    {
        super();

        this.host = host;
        createInstance();

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

    private function get instance():Button
    {
        return _instance as Button;
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override protected function createInstance():void
    {
        this._instance =  new Button();
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  Methods: Sprite
    //------------------------------------

    public function x(value:Object):ButtonBuilder
    {
        spriteMixin.x(value);

        return this;
    }

    public function y(value:Object):ButtonBuilder
    {
        spriteMixin.y(value);

        return this;
    }

    public function width(value:Object):ButtonBuilder
    {
        spriteMixin.width(value);

        return this;
    }

    public function height(value:Object):ButtonBuilder
    {
        spriteMixin.height(value);

        return this;
    }

    public function rotation(value:Object, axis:String = null):ButtonBuilder
    {
        spriteMixin.rotation(value, axis);

        return this;
    }

    public function visible(value:Object):ButtonBuilder
    {
        spriteMixin.visible(value);

        return this;
    }

    public function alpha(value:Object):ButtonBuilder
    {
        spriteMixin.alpha(value);

        return this;
    }

    public function z(value:Object):ButtonBuilder
    {
        spriteMixin.z(value);

        return this;
    }

    public function scale(value:Object, axis:String = null):ButtonBuilder
    {
        spriteMixin.scale(value, axis);

        return this;
    }

    public function mask(value:Object):ButtonBuilder
    {
        spriteMixin.mask(value);

        return this;
    }

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    public function on(type:String, handler:Function, weak:Boolean = true):ButtonBuilder
    {
        eventDispatcherMixin.on(type, handler, weak);

        return this;
    }

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    public function left(value:Object):ButtonBuilder
    {
        layoutElementMixin.left(value);

        return this;
    }

    public function top(value:Object):ButtonBuilder
    {
        layoutElementMixin.top(value);

        return this;
    }

    public function right(value:Object):ButtonBuilder
    {
        layoutElementMixin.right(value);

        return this;
    }

    public function bottom(value:Object):ButtonBuilder
    {
        layoutElementMixin.bottom(value);

        return this;
    }

    public function horizontalCenter(value:Object):ButtonBuilder
    {
        layoutElementMixin.horizontalCenter(value);

        return this;
    }

    public function verticalCenter(value:Object):ButtonBuilder
    {
        layoutElementMixin.verticalCenter(value);

        return this;
    }

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    public function id(id:Object):ButtonBuilder
    {
        this.instanceId = id;

        return this;
    }

    public function styleName(value:Object):ButtonBuilder
    {
        componentMixin.styleName(value);

        return this;
    }

    public function enabled(value:Object):ButtonBuilder
    {
        componentMixin.enabled(value);

        return this;
    }

    //-----------------------------------
    //  Methods: Button
    //-----------------------------------

    public function label(value:Object):ButtonBuilder
    {
        PropertySetter.set(this.instance, "label", value);

        return this;
    }

    public function toggled(value:Object):ButtonBuilder
    {
        PropertySetter.set(this.instance, "isToggle", value);

        return this;
    }

    public function selected(value:Object):ButtonBuilder
    {
        PropertySetter.set(this.instance, "isSelected", value);

        return this;
    }
}
}
