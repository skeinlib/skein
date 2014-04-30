/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 1:36 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.components
{
import feathers.controls.Label;

import skein.components.builder.components.LabelBuilder;
import skein.components.builder.mixins.ComponentMixin;
import skein.components.builder.mixins.EventDispatcherMixin;
import skein.components.builder.mixins.LayoutElementMixin;
import skein.components.builder.mixins.ObjectNature;
import skein.components.builder.mixins.SpriteMixin;
import skein.components.builder.mixins.impl.DefaultObjectNature;
import skein.core.PropertySetter;
import skein.impl.feathers.components.builder.*;
import skein.impl.feathers.components.builder.mixins.FeathersComponentNature;
import skein.impl.feathers.components.builder.mixins.FeathersEventDispatcherNature;
import skein.impl.feathers.components.builder.mixins.FeathersLayoutElementNature;
import skein.impl.feathers.components.builder.mixins.FeathersSpriteNature;

public class FeathersLabelBuilder extends FeathersBuilder implements LabelBuilder
{
    public function FeathersLabelBuilder(host:Object, generator:Class = null)
    {
        super();

        this.host = host;

        this._instance = generator ? new generator() : new Label();

        this.objectNature = new DefaultObjectNature(this.instance);
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
    //  Variables: Natures
    //-------------------------------------

    private var objectNature:ObjectNature;

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

    private function get instance():Label
    {
        return _instance as Label;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  Methods: Sprite
    //------------------------------------

    public function x(value:Object):LabelBuilder
    {
        spriteMixin.x(value);

        return this;
    }

    public function y(value:Object):LabelBuilder
    {
        spriteMixin.y(value);

        return this;
    }

    public function width(value:Object):LabelBuilder
    {
        spriteMixin.width(value);

        return this;
    }

    public function height(value:Object):LabelBuilder
    {
        spriteMixin.height(value);

        return this;
    }

    public function rotation(value:Object, axis:String = null):LabelBuilder
    {
        spriteMixin.rotation(value, axis);

        return this;
    }

    public function visible(value:Object):LabelBuilder
    {
        spriteMixin.visible(value);

        return this;
    }

    public function alpha(value:Object):LabelBuilder
    {
        spriteMixin.alpha(value);

        return this;
    }

    public function z(value:Object):LabelBuilder
    {
        spriteMixin.z(value);

        return this;
    }

    public function scale(value:Object, axis:String = null):LabelBuilder
    {
        spriteMixin.scale(value, axis);

        return this;
    }

    public function mask(value:Object):LabelBuilder
    {
        spriteMixin.mask(value);

        return this;
    }

    //------------------------------------
    //  Methods: Object
    //------------------------------------

    public function set(property:String, value:Object):LabelBuilder
    {
        objectNature.set(property, value);

        return this;
    }

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    public function on(type:String, handler:Function, weak:Boolean = true):LabelBuilder
    {
        eventDispatcherMixin.on(type, handler, weak);

        return this;
    }

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    public function left(value:Object):LabelBuilder
    {
        layoutElementMixin.left(value);

        return this;
    }

    public function top(value:Object):LabelBuilder
    {
        layoutElementMixin.top(value);

        return this;
    }

    public function right(value:Object):LabelBuilder
    {
        layoutElementMixin.right(value);

        return this;
    }

    public function bottom(value:Object):LabelBuilder
    {
        layoutElementMixin.bottom(value);

        return this;
    }

    public function horizontalCenter(value:Object):LabelBuilder
    {
        layoutElementMixin.horizontalCenter(value);

        return this;
    }

    public function verticalCenter(value:Object):LabelBuilder
    {
        layoutElementMixin.verticalCenter(value);

        return this;
    }

    public function includeInLayout(value:Object):LabelBuilder
    {
        layoutElementMixin.includeInLayout(value);

        return this;
    }

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    public function id(id:Object):LabelBuilder
    {
        this.instanceId = id;

        return this;
    }

    public function styleName(value:Object):LabelBuilder
    {
        componentMixin.styleName(value);

        return this;
    }

    public function enabled(value:Object):LabelBuilder
    {
        componentMixin.enabled(value);

        return this;
    }

    //-----------------------------------
    //  Methods: Label
    //-----------------------------------

    public function text(value:Object):LabelBuilder
    {
        PropertySetter.set(this.instance, "text", value);

        return this;
    }

    public function textAlign(value:Object):LabelBuilder
    {
        PropertySetter.set(this.instance.textRendererProperties, "textAlign", value);

        return this;
    }

    public function wordWrap(value:Object):LabelBuilder
    {
        PropertySetter.set(this.instance.textRendererProperties, "wordWrap", value);

        return this;
    }

    public function lineBreak(value:Object):LabelBuilder
    {
        return this;
    }
}
}
