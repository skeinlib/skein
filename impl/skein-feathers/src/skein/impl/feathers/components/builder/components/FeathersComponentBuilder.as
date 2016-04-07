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
import feathers.core.IFeathersControl;
import feathers.layout.ILayoutDisplayObject;

import skein.components.builder.components.ComponentBuilder;

import skein.components.builder.components.ComponentBuilder;
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

import starling.display.Sprite;

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

        this.eventDispatcherNature = new FeathersEventDispatcherNature(_instance);

        if (_instance is Sprite)
        {
            this.spriteNature = new FeathersSpriteNature(_instance as Sprite);
        }

        if (_instance is IFeathersControl)
        {
            this.componentMixin = new FeathersComponentNature(_instance as IFeathersControl);
        }

        if (_instance is ILayoutDisplayObject)
        {
            this.layoutElementNature = new FeathersLayoutElementNature(_instance as ILayoutDisplayObject);
        }
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

    private var spriteNature:SpriteMixin;

    private var componentMixin:ComponentMixin;

    private var layoutElementNature:LayoutElementMixin;

    private var eventDispatcherNature:EventDispatcherMixin;

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

    override protected function createInstance(generator:Class = null):void
    {
        if (factory is Class)
        {
            _instance = new factory();
        }
        else if (factory is Function)
        {
            _instance = (factory as Function)();
        }
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
        spriteNature.x(value);

        return this;
    }

    public function y(value:Object):ComponentBuilder
    {
        spriteNature.y(value);

        return this;
    }

    public function width(value:Object):ComponentBuilder
    {
        spriteNature.width(value);

        return this;
    }

    public function height(value:Object):ComponentBuilder
    {
        spriteNature.height(value);

        return this;
    }

    public function rotation(value:Object, axis:String = null):ComponentBuilder
    {
        spriteNature.rotation(value, axis);

        return this;
    }

    public function visible(value:Object):ComponentBuilder
    {
        spriteNature.visible(value);

        return this;
    }

    public function alpha(value:Object):ComponentBuilder
    {
        spriteNature.alpha(value);

        return this;
    }

    public function z(value:Object):ComponentBuilder
    {
        spriteNature.z(value);

        return this;
    }

    public function scale(value:Object, axis:String = null):ComponentBuilder
    {
        spriteNature.scale(value, axis);

        return this;
    }

    public function mask(value:Object):ComponentBuilder
    {
        spriteNature.mask(value);

        return this;
    }

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    public function on(type:String, handler:Function, weak:Boolean = true):ComponentBuilder
    {
        eventDispatcherNature.on(type, handler, weak);

        return this;
    }

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    public function left(value:Object):ComponentBuilder
    {
        layoutElementNature.left(value);

        return this;
    }

    public function leftAnchor(value:Object):ComponentBuilder
    {
        layoutElementNature.leftAnchor(value);

        return this;
    }

    public function top(value:Object):ComponentBuilder
    {
        layoutElementNature.top(value);

        return this;
    }

    public function topAnchor(value:Object):ComponentBuilder
    {
        layoutElementNature.topAnchor(value);

        return this;
    }

    public function right(value:Object):ComponentBuilder
    {
        layoutElementNature.right(value);

        return this;
    }

    public function rightAnchor(value:Object):ComponentBuilder
    {
        layoutElementNature.rightAnchor(value);

        return this;
    }

    public function bottom(value:Object):ComponentBuilder
    {
        layoutElementNature.bottom(value);

        return this;
    }

    public function bottomAnchor(value:Object):ComponentBuilder
    {
        layoutElementNature.bottomAnchor(value);

        return this;
    }

    public function horizontalCenter(value:Object):ComponentBuilder
    {
        layoutElementNature.horizontalCenter(value);

        return this;
    }

    public function horizontalCenterAnchor(value:Object):ComponentBuilder
    {
        layoutElementNature.horizontalCenterAnchor(value);

        return this;
    }

    public function verticalCenter(value:Object):ComponentBuilder
    {
        layoutElementNature.verticalCenter(value);

        return this;
    }

    public function verticalCenterAnchor(value:Object):ComponentBuilder
    {
        layoutElementNature.verticalCenterAnchor(value);

        return this;
    }

    public function includeInLayout(value:Object):ComponentBuilder
    {
        layoutElementNature.includeInLayout(value);

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
        PropertySetter.set(_instance, property, value);

        return this;
    }
}
}
