/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/20/13
 * Time: 11:32 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.components
{
import feathers.controls.ScrollContainer;
import feathers.layout.AnchorLayout;
import feathers.layout.VerticalLayout;

import skein.components.builder.components.GroupBuilder;
import skein.components.builder.mixins.ComponentMixin;
import skein.components.builder.mixins.ElementContainerMixin;
import skein.components.builder.mixins.EventDispatcherMixin;
import skein.components.builder.mixins.LayoutElementMixin;
import skein.components.builder.mixins.SpriteMixin;
import skein.components.core.ComponentsGlobals;
import skein.components.enum.Side;
import skein.core.PropertySetter;
import skein.core.skein_internal;
import skein.impl.feathers.components.builder.FeathersBuilder;
import skein.impl.feathers.components.builder.mixins.FeathersComponentNature;
import skein.impl.feathers.components.builder.mixins.FeathersElementContainerMixin;
import skein.impl.feathers.components.builder.mixins.FeathersEventDispatcherNature;
import skein.impl.feathers.components.builder.mixins.FeathersLayoutElementNature;
import skein.impl.feathers.components.builder.mixins.FeathersSpriteNature;

use namespace skein_internal;

public class FeathersGroupBuilder extends FeathersBuilder implements GroupBuilder
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function FeathersGroupBuilder(host:Object)
    {
        super();

        this.host = host;

        new VerticalLayout().hasOwnProperty("gap");

        this.createInstance();

        this.spriteMixin = new FeathersSpriteNature(this.instance);
        this.componentMixin = new FeathersComponentNature(this.instance);
        this.layoutElementMixin = new FeathersLayoutElementNature(this.instance);
        this.eventDispatcherMixin = new FeathersEventDispatcherNature(this.instance);
        this.elementContainerMixin = new FeathersElementContainerMixin(this.instance);
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
    
    private var elementContainerMixin:ElementContainerMixin;

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  instance
    //-------------------------------------

    protected function get instance():ScrollContainer
    {
        return _instance as ScrollContainer;
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override protected function createInstance():void
    {
        this._instance = new ScrollContainer();
        this.instance.layout = new AnchorLayout();
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  Methods: Sprite
    //------------------------------------

    public function x(value:Object):GroupBuilder
    {
        spriteMixin.x(value);

        return this;
    }

    public function y(value:Object):GroupBuilder
    {
        spriteMixin.y(value);

        return this;
    }

    public function width(value:Object):GroupBuilder
    {
        spriteMixin.width(value);

        return this;
    }

    public function height(value:Object):GroupBuilder
    {
        spriteMixin.height(value);

        return this;
    }

    public function rotation(value:Object, axis:String = null):GroupBuilder
    {
        spriteMixin.rotation(value, axis);

        return this;
    }

    public function visible(value:Object):GroupBuilder
    {
        spriteMixin.visible(value);

        return this;
    }

    public function alpha(value:Object):GroupBuilder
    {
        spriteMixin.alpha(value);

        return this;
    }

    public function z(value:Object):GroupBuilder
    {
        spriteMixin.z(value);

        return this;
    }

    public function scale(value:Object, axis:String = null):GroupBuilder
    {
        spriteMixin.scale(value, axis);

        return this;
    }

    public function mask(value:Object):GroupBuilder
    {
        spriteMixin.mask(value);

        return this;
    }

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    public function on(type:String, handler:Function, weak:Boolean = true):GroupBuilder
    {
        eventDispatcherMixin.on(type, handler, weak);

        return this;
    }

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    public function left(value:Object):GroupBuilder
    {
        layoutElementMixin.left(value);

        return this;
    }

    public function top(value:Object):GroupBuilder
    {
        layoutElementMixin.top(value);

        return this;
    }

    public function right(value:Object):GroupBuilder
    {
        layoutElementMixin.right(value);

        return this;
    }

    public function bottom(value:Object):GroupBuilder
    {
        layoutElementMixin.bottom(value);

        return this;
    }

    public function horizontalCenter(value:Object):GroupBuilder
    {
        layoutElementMixin.horizontalCenter(value);

        return this;
    }

    public function verticalCenter(value:Object):GroupBuilder
    {
        layoutElementMixin.verticalCenter(value);

        return this;
    }

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    public function id(id:Object):GroupBuilder
    {
        this.instanceId = id;

        return this;
    }

    public function styleName(value:Object):GroupBuilder
    {
        componentMixin.styleName(value);

        return this;
    }

    public function enabled(value:Object):GroupBuilder
    {
        componentMixin.enabled(value);

        return this;
    }

    //-----------------------------------
    //  Methods: Group
    //-----------------------------------

    public function contains(...elements):GroupBuilder
    {
        elementContainerMixin.contains(elements);

        return this;
    }

    public function layout(value:Object):GroupBuilder
    {
//        PropertySetter.set(this.instance, "layout", value);

        // what if layout has been changed after set it's properties?

        return this;
    }

    public function gap(value:Object):GroupBuilder
    {
        if (this.instance.layout && "gap" in this.instance.layout)
            PropertySetter.set(this.instance.layout, "gap", value);

        return this;
    }

    public function padding(value:Object, side:String = null):GroupBuilder
    {
        switch (side)
        {
            case Side.LEFT : paddingLeft(value);  break;
            case Side.TOP : paddingTop(value);  break;
            case Side.RIGHT : paddingRight(value);  break;
            case Side.BOTTOM : paddingBottom(value);  break;
            default :

                paddingLeft(value);
                paddingTop(value);
                paddingRight(value);
                paddingBottom(value);

                break;
        }

        return this;
    }

    public function paddingLeft(value:Object):GroupBuilder
    {
        if (this.instance.layout && "paddingLeft" in this.instance.layout)
            PropertySetter.set(this.instance.layout, "paddingLeft", value);

        return this;
    }

    public function paddingTop(value:Object):GroupBuilder
    {
        if (this.instance.layout && "paddingTop" in this.instance.layout)
            PropertySetter.set(this.instance.layout, "paddingTop", value);

        return this;
    }

    public function paddingRight(value:Object):GroupBuilder
    {
        if (this.instance.layout && "paddingRight" in this.instance.layout)
            PropertySetter.set(this.instance.layout, "paddingRight", value);

        return this;
    }

    public function paddingBottom(value:Object):GroupBuilder
    {
        if (this.instance.layout && "paddingBottom" in this.instance.layout)
            PropertySetter.set(this.instance.layout, "paddingBottom", value);

        return this;
    }

    public function horizontalAlign(value:Object):GroupBuilder
    {
        if (this.instance.layout && "horizontalAlign" in this.instance.layout)
            PropertySetter.set(this.instance.layout, "horizontalAlign", value);

        return this;
    }

    public function verticalAlign(value:Object):GroupBuilder
    {
        if (this.instance.layout && "verticalAlign" in this.instance.layout)
            PropertySetter.set(this.instance.layout, "verticalAlign", value);

        return this;
    }

    public function horizontalScrollPolicy(value:Object):GroupBuilder
    {
        PropertySetter.set(this.instance, "horizontalScrollPolicy", value);

        return this;
    }

    public function verticalScrollPolicy(value:Object):GroupBuilder
    {
        PropertySetter.set(this.instance, "verticalScrollPolicy", value);

        return this;
    }

    //-----------------------------------
    //  Methods: Extra
    //-----------------------------------

    public function bindWidthTo(source:Object):GroupBuilder
    {
        ComponentsGlobals.bindWidth(source, this.instance);

        return this;
    }

    public function bindHeightTo(source:Object):GroupBuilder
    {
        ComponentsGlobals.bindHeight(source, this.instance);

        return this;
    }

}
}
