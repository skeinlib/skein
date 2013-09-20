/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/30/13
 * Time: 1:56 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.components
{
import feathers.controls.ScrollText;

import skein.components.builder.components.TextBuilder;
import skein.components.builder.mixins.ComponentMixin;
import skein.components.builder.mixins.EventDispatcherMixin;
import skein.components.builder.mixins.LayoutElementMixin;
import skein.components.builder.mixins.PadElementNature;
import skein.components.builder.mixins.SpriteMixin;
import skein.components.builder.mixins.impl.DefaultPadElementNature;
import skein.core.PropertySetter;
import skein.impl.feathers.components.builder.FeathersBuilder;
import skein.impl.feathers.components.builder.mixins.FeathersComponentNature;
import skein.impl.feathers.components.builder.mixins.FeathersEventDispatcherNature;
import skein.impl.feathers.components.builder.mixins.FeathersLayoutElementNature;
import skein.impl.feathers.components.builder.mixins.FeathersSpriteNature;

public class FeathersTextBuilder extends FeathersBuilder implements TextBuilder
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function FeathersTextBuilder(host:Object, generator:Class=null)
    {
        super();

        this.host = host;

        this._instance = generator ? new generator() : new ScrollText();

        this.spriteNature = new FeathersSpriteNature(this.instance);
        this.componentNature = new FeathersComponentNature(this.instance);
        this.padElementNature = new DefaultPadElementNature(this.instance);
        this.layoutElementNature = new FeathersLayoutElementNature(this.instance);
        this.eventDispatcherNature = new FeathersEventDispatcherNature(this.instance);
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Variables: Natures
    //-------------------------------------

    private var spriteNature:SpriteMixin;

    private var componentNature:ComponentMixin;

    private var padElementNature:PadElementNature;

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

    private function get instance():ScrollText
    {
        return _instance as ScrollText;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  Methods: Object
    //------------------------------------

    public function set(property:String, value:Object):TextBuilder
    {
        PropertySetter.set(instance, property, value);

        return this;
    }

    //------------------------------------
    //  Methods: Sprite
    //------------------------------------

    public function x(value:Object):TextBuilder
    {
        spriteNature.x(value);

        return this;
    }

    public function y(value:Object):TextBuilder
    {
        spriteNature.y(value);

        return this;
    }

    public function width(value:Object):TextBuilder
    {
        spriteNature.width(value);

        return this;
    }

    public function height(value:Object):TextBuilder
    {
        spriteNature.height(value);

        return this;
    }

    public function rotation(value:Object, axis:String = null):TextBuilder
    {
        spriteNature.rotation(value, axis);

        return this;
    }

    public function visible(value:Object):TextBuilder
    {
        spriteNature.visible(value);

        return this;
    }

    public function alpha(value:Object):TextBuilder
    {
        spriteNature.alpha(value);

        return this;
    }

    public function z(value:Object):TextBuilder
    {
        spriteNature.z(value);

        return this;
    }

    public function scale(value:Object, axis:String = null):TextBuilder
    {
        spriteNature.scale(value, axis);

        return this;
    }

    public function mask(value:Object):TextBuilder
    {
        spriteNature.mask(value);

        return this;
    }

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    public function on(type:String, handler:Function, weak:Boolean = true):TextBuilder
    {
        eventDispatcherNature.on(type, handler, weak);

        return this;
    }

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    public function left(value:Object):TextBuilder
    {
        layoutElementNature.left(value);

        return this;
    }

    public function top(value:Object):TextBuilder
    {
        layoutElementNature.top(value);

        return this;
    }

    public function right(value:Object):TextBuilder
    {
        layoutElementNature.right(value);

        return this;
    }

    public function bottom(value:Object):TextBuilder
    {
        layoutElementNature.bottom(value);

        return this;
    }

    public function horizontalCenter(value:Object):TextBuilder
    {
        layoutElementNature.horizontalCenter(value);

        return this;
    }

    public function verticalCenter(value:Object):TextBuilder
    {
        layoutElementNature.verticalCenter(value);

        return this;
    }

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    public function id(id:Object):TextBuilder
    {
        this.instanceId = id;

        return this;
    }

    public function styleName(value:Object):TextBuilder
    {
        componentNature.styleName(value);

        return this;
    }

    public function enabled(value:Object):TextBuilder
    {
        componentNature.enabled(value);

        return this;
    }

    //-----------------------------------
    //  Methods: PadElement
    //-----------------------------------

    public function padding(value:Object):TextBuilder
    {
        padElementNature.padding(value);

        return this;
    }

    public function paddingLeft(value:Object):TextBuilder
    {
        padElementNature.paddingLeft(value);

        return this;
    }

    public function paddingTop(value:Object):TextBuilder
    {
        padElementNature.paddingTop(value);

        return this;
    }

    public function paddingRight(value:Object):TextBuilder
    {
        padElementNature.paddingRight(value);

        return this;
    }

    public function paddingBottom(value:Object):TextBuilder
    {
        padElementNature.paddingBottom(value);

        return this;
    }

    //-----------------------------------
    //  Methods: Text
    //-----------------------------------

    public function border(value:Object):TextBuilder
    {
        PropertySetter.set(instance, "border", value);

        return this;
    }

    public function borderColor(value:Object):TextBuilder
    {
        PropertySetter.set(instance, "borderColor", value);

        return this;
    }

    public function isHTML(value:Object):TextBuilder
    {
        PropertySetter.set(instance, "isHTML", value);

        return this;
    }

    public function condenseWhite(value:Object):TextBuilder
    {
        PropertySetter.set(instance, "condenseWhite", value);

        return this;
    }

    public function displayAsPassword(value:Object):TextBuilder
    {
        PropertySetter.set(instance, "displayAsPassword", value);

        return this;
    }

    public function gridFitType(value:Object):TextBuilder
    {
        PropertySetter.set(instance, "gridFitType", value);

        return this;
    }

    public function sharpness(value:Object):TextBuilder
    {
        PropertySetter.set(instance, "sharpness", value);

        return this;
    }

    public function thickness(value:Object):TextBuilder
    {
        PropertySetter.set(instance, "thickness", value);

        return this;
    }

    public function text(value:Object):TextBuilder
    {
        PropertySetter.set(instance, "text", value);

        return this;
    }

    public function styleSheet(value:Object):TextBuilder
    {
        PropertySetter.set(instance, "styleSheet", value);

        return this;
    }
}
}
