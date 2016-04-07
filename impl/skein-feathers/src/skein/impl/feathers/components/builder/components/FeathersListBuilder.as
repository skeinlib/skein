/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 1:29 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.components
{
import feathers.controls.List;

import skein.components.builder.components.ListBuilder;

import skein.components.builder.components.ListBuilder;
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

public class FeathersListBuilder extends FeathersBuilder implements ListBuilder
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function FeathersListBuilder(host:Object, generator:Class=null)
    {
        super();

        this.host = host;
        this._instance = generator ? new generator() : new List();

        this.spriteMixin = new FeathersSpriteNature(this.instance);
        this.componentMixin = new FeathersComponentNature(this.instance);
        this.layoutElementNature = new FeathersLayoutElementNature(this.instance);
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

    private var layoutElementNature:LayoutElementMixin;

    private var eventDispatcherMixin:EventDispatcherMixin;

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  instance
    //-------------------------------------

    private function get instance():List
    {
        return _instance as List;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  Methods: Object
    //------------------------------------

    public function set(property:String, value:Object):ListBuilder
    {
        PropertySetter.set(instance, property, value);

        return this;
    }

    //------------------------------------
    //  Methods: Sprite
    //------------------------------------

    public function x(value:Object):ListBuilder
    {
        spriteMixin.x(value);

        return this;
    }

    public function y(value:Object):ListBuilder
    {
        spriteMixin.y(value);

        return this;
    }

    public function width(value:Object):ListBuilder
    {
        spriteMixin.width(value);

        return this;
    }

    public function height(value:Object):ListBuilder
    {
        spriteMixin.height(value);

        return this;
    }

    public function maxWidth(value:Object):ListBuilder
    {
        spriteMixin.maxWidth(value);

        return this;
    }

    public function maxHeight(value:Object):ListBuilder
    {
        spriteMixin.maxHeight(value);

        return this;
    }

    public function rotation(value:Object, axis:String = null):ListBuilder
    {
        spriteMixin.rotation(value, axis);

        return this;
    }

    public function visible(value:Object):ListBuilder
    {
        spriteMixin.visible(value);

        return this;
    }

    public function alpha(value:Object):ListBuilder
    {
        spriteMixin.alpha(value);

        return this;
    }

    public function z(value:Object):ListBuilder
    {
        spriteMixin.z(value);

        return this;
    }

    public function scale(value:Object, axis:String = null):ListBuilder
    {
        spriteMixin.scale(value, axis);

        return this;
    }

    public function mask(value:Object):ListBuilder
    {
        spriteMixin.mask(value);

        return this;
    }

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    public function on(type:String, handler:Function, weak:Boolean = true):ListBuilder
    {
        eventDispatcherMixin.on(type, handler, weak);

        return this;
    }

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    public function left(value:Object):ListBuilder
    {
        layoutElementNature.left(value);

        return this;
    }

    public function leftAnchor(value:Object):ListBuilder
    {
        layoutElementNature.leftAnchor(value);

        return this;
    }

    public function top(value:Object):ListBuilder
    {
        layoutElementNature.top(value);

        return this;
    }

    public function topAnchor(value:Object):ListBuilder
    {
        layoutElementNature.topAnchor(value);

        return this;
    }

    public function right(value:Object):ListBuilder
    {
        layoutElementNature.right(value);

        return this;
    }

    public function rightAnchor(value:Object):ListBuilder
    {
        layoutElementNature.rightAnchor(value);

        return this;
    }

    public function bottom(value:Object):ListBuilder
    {
        layoutElementNature.bottom(value);

        return this;
    }

    public function bottomAnchor(value:Object):ListBuilder
    {
        layoutElementNature.bottomAnchor(value);

        return this;
    }

    public function horizontalCenter(value:Object):ListBuilder
    {
        layoutElementNature.horizontalCenter(value);

        return this;
    }

    public function horizontalCenterAnchor(value:Object):ListBuilder
    {
        layoutElementNature.horizontalCenterAnchor(value);

        return this;
    }

    public function verticalCenter(value:Object):ListBuilder
    {
        layoutElementNature.verticalCenter(value);

        return this;
    }

    public function verticalCenterAnchor(value:Object):ListBuilder
    {
        layoutElementNature.verticalCenterAnchor(value);

        return this;
    }

    public function includeInLayout(value:Object):ListBuilder
    {
        layoutElementNature.includeInLayout(value);

        return this;
    }

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    public function id(id:Object):ListBuilder
    {
        this.instanceId = id;

        return this;
    }

    public function styleName(value:Object):ListBuilder
    {
        componentMixin.styleName(value);

        return this;
    }

    public function enabled(value:Object):ListBuilder
    {
        componentMixin.enabled(value);

        return this;
    }

    //-----------------------------------
    //  Methods: List
    //-----------------------------------
    
    public function layout(value:Object):ListBuilder
    {
        PropertySetter.set(this.instance, "layout", value);
        
        return this;
    }

    public function provider(value:Object):ListBuilder
    {
        PropertySetter.set(this.instance, "dataProvider", value);
        
        return this;
    }

    public function item(value:Object):ListBuilder
    {
        PropertySetter.set(this.instance, "selectedItem", value);

        return this;
    }

    public function index(value:Object):ListBuilder
    {
        PropertySetter.set(this.instance, "selectedIndex", value);

        return this;
    }

    public function selectable(value:Object):ListBuilder
    {
        PropertySetter.set(this.instance, "isSelectable", value);

        return this;
    }

    // TODO: Consider support for binding
    public function renderer(value:Object):ListBuilder
    {
        if (value is Function)
        {
            this.instance.itemRendererFactory = value as Function;
        }
        else if (value is Class)
        {
            this.instance.itemRendererType = value as Class;
        }

        return this;
    }

    public function labelField(value:Object):ListBuilder
    {
        PropertySetter.set(this.instance.itemRendererProperties, "labelField", value);

        return this;
    }

    public function labelFunction(value:Object):ListBuilder
    {
        PropertySetter.set(this.instance.itemRendererProperties, "labelFunction", value);

        return this;
    }
}
}
