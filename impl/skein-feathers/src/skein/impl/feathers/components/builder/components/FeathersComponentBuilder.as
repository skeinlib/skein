/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/10/13
 * Time: 12:11 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.components
{
import feathers.core.FeathersControl;

import skein.components.builder.components.ComponentBuilder;
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

public class FeathersComponentBuilder extends FeathersBuilder implements ComponentBuilder
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function FeathersComponentBuilder(host:Object, factory:Object)
    {
        super();

        this.host = host;
        this.factory = factory;

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
    //  Variables: Generator
    //-------------------------------------

    private var factory:Object;

    //-------------------------------------
    //  Variables: Natures
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

    private function get instance():FeathersControl
    {
        return _instance as FeathersControl;
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override protected function createInstance():void
    {
        if (factory is Class)
            this._instance = new factory();
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  Methods: Sprite
    //------------------------------------

    public function x(value:Object):ComponentBuilder
    {
        spriteMixin.x(value);

        return this;
    }

    public function y(value:Object):ComponentBuilder
    {
        spriteMixin.y(value);

        return this;
    }

    public function width(value:Object):ComponentBuilder
    {
        spriteMixin.width(value);

        return this;
    }

    public function height(value:Object):ComponentBuilder
    {
        spriteMixin.height(value);

        return this;
    }

    public function rotation(value:Object, axis:String = null):ComponentBuilder
    {
        spriteMixin.rotation(value, axis);

        return this;
    }

    public function visible(value:Object):ComponentBuilder
    {
        spriteMixin.visible(value);

        return this;
    }

    public function alpha(value:Object):ComponentBuilder
    {
        spriteMixin.alpha(value);

        return this;
    }

    public function z(value:Object):ComponentBuilder
    {
        spriteMixin.z(value);

        return this;
    }

    public function scale(value:Object, axis:String = null):ComponentBuilder
    {
        spriteMixin.scale(value, axis);

        return this;
    }

    public function mask(value:Object):ComponentBuilder
    {
        spriteMixin.mask(value);

        return this;
    }

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    public function on(type:String, handler:Function, weak:Boolean = true):ComponentBuilder
    {
        eventDispatcherMixin.on(type, handler, weak);

        return this;
    }

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    public function left(value:Object):ComponentBuilder
    {
        layoutElementMixin.left(value);

        return this;
    }

    public function top(value:Object):ComponentBuilder
    {
        layoutElementMixin.top(value);

        return this;
    }

    public function right(value:Object):ComponentBuilder
    {
        layoutElementMixin.right(value);

        return this;
    }

    public function bottom(value:Object):ComponentBuilder
    {
        layoutElementMixin.bottom(value);

        return this;
    }

    public function horizontalCenter(value:Object):ComponentBuilder
    {
        layoutElementMixin.horizontalCenter(value);

        return this;
    }

    public function verticalCenter(value:Object):ComponentBuilder
    {
        layoutElementMixin.verticalCenter(value);

        return this;
    }

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    public function id(id:Object):ComponentBuilder
    {
        this.instanceId = id;

        return this;
    }

    public function styleName(value:Object):ComponentBuilder
    {
        componentMixin.styleName(value);

        return this;
    }

    public function enabled(value:Object):ComponentBuilder
    {
        componentMixin.enabled(value);

        return this;
    }

    public function set(property:String, value:Object):ComponentBuilder
    {
        PropertySetter.set(this.instance, property, value);

        return this;
    }
}
}
