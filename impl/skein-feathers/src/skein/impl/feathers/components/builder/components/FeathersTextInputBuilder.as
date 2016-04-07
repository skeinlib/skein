/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/20/13
 * Time: 12:26 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.components
{
import feathers.controls.TextInput;

import skein.components.builder.components.TextInputBuilder;
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

public class FeathersTextInputBuilder extends FeathersBuilder implements TextInputBuilder
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function FeathersTextInputBuilder(host:Object, generator:Class=null)
    {
        super();

        this.host = host;
        this._instance = generator ? new generator() : new TextInput();

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

    private function get instance():TextInput
    {
        return _instance as TextInput;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  Methods: Object
    //------------------------------------

    public function set(property:String, value:Object):TextInputBuilder
    {
        PropertySetter.set(this.instance, property, value);

        return this;
    }

    //------------------------------------
    //  Methods: Sprite
    //------------------------------------

    public function x(value:Object):TextInputBuilder
    {
        spriteMixin.x(value);

        return this;
    }

    public function y(value:Object):TextInputBuilder
    {
        spriteMixin.y(value);

        return this;
    }

    public function width(value:Object):TextInputBuilder
    {
        spriteMixin.width(value);

        return this;
    }

    public function height(value:Object):TextInputBuilder
    {
        spriteMixin.height(value);

        return this;
    }

    public function rotation(value:Object, axis:String = null):TextInputBuilder
    {
        spriteMixin.rotation(value, axis);

        return this;
    }

    public function visible(value:Object):TextInputBuilder
    {
        spriteMixin.visible(value);

        return this;
    }

    public function alpha(value:Object):TextInputBuilder
    {
        spriteMixin.alpha(value);

        return this;
    }

    public function z(value:Object):TextInputBuilder
    {
        spriteMixin.z(value);

        return this;
    }

    public function scale(value:Object, axis:String = null):TextInputBuilder
    {
        spriteMixin.scale(value, axis);

        return this;
    }

    public function mask(value:Object):TextInputBuilder
    {
        spriteMixin.mask(value);

        return this;
    }

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    public function on(type:String, handler:Function, weak:Boolean = true):TextInputBuilder
    {
        eventDispatcherMixin.on(type, handler, weak);

        return this;
    }

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------


    public function left(value:Object):TextInputBuilder
    {
        layoutElementNature.left(value);

        return this;
    }

    public function leftAnchor(value:Object):TextInputBuilder
    {
        layoutElementNature.leftAnchor(value);

        return this;
    }

    public function top(value:Object):TextInputBuilder
    {
        layoutElementNature.top(value);

        return this;
    }

    public function topAnchor(value:Object):TextInputBuilder
    {
        layoutElementNature.topAnchor(value);

        return this;
    }

    public function right(value:Object):TextInputBuilder
    {
        layoutElementNature.right(value);

        return this;
    }

    public function rightAnchor(value:Object):TextInputBuilder
    {
        layoutElementNature.rightAnchor(value);

        return this;
    }

    public function bottom(value:Object):TextInputBuilder
    {
        layoutElementNature.bottom(value);

        return this;
    }

    public function bottomAnchor(value:Object):TextInputBuilder
    {
        layoutElementNature.bottomAnchor(value);

        return this;
    }

    public function horizontalCenter(value:Object):TextInputBuilder
    {
        layoutElementNature.horizontalCenter(value);

        return this;
    }

    public function verticalCenter(value:Object):TextInputBuilder
    {
        layoutElementNature.verticalCenter(value);

        return this;
    }

    public function includeInLayout(value:Object):TextInputBuilder
    {
        layoutElementNature.includeInLayout(value);

        return this;
    }

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    public function id(id:Object):TextInputBuilder
    {
        this.instanceId = id;

        return this;
    }

    public function styleName(value:Object):TextInputBuilder
    {
        componentMixin.styleName(value);

        return this;
    }

    public function enabled(value:Object):TextInputBuilder
    {
        componentMixin.enabled(value);

        return this;
    }

    //-----------------------------------
    //  Methods: textInput
    //-----------------------------------

    public function text(value:Object):TextInputBuilder
    {
        PropertySetter.set(this.instance, "text", value);

        return this;
    }

    public function multiline(value:Object):TextInputBuilder
    {
        PropertySetter.set(this.instance.textEditorProperties, "multiline", value);

        return this;
    }

    public function wordWrap(value:Object):TextInputBuilder
    {
        PropertySetter.set(this.instance.textEditorProperties, "wordWrap", value);

        return this;
    }

    public function prompt(value:Object):TextInputBuilder
    {
        PropertySetter.set(this.instance, "prompt", value);

        return this;
    }

    public function restrict(value:Object):TextInputBuilder
    {
        PropertySetter.set(this.instance.textEditorProperties, "restrict", value);

        return this;
    }


    public function editable(value:Object):TextInputBuilder
    {
        PropertySetter.set(this.instance, "isEditable", value);

        return this;
    }

    public function displayAsPassword(value:Object):TextInputBuilder
    {
        PropertySetter.set(this.instance.textEditorProperties, "displayAsPassword", value);

        return this;
    }

    public function textAlign(value:Object):TextInputBuilder
    {
//        PropertySetter.set(this.instance.textEditorProperties, "textAlign", value);
//        PropertySetter.set(this.instance.promptProperties, "textFormat.@align", value);

        return this;
    }

    public function maxChars(value:Object):TextInputBuilder
    {
        PropertySetter.set(this.instance, "maxChars", value);

        return this;
    }

    public function softKeyboardType(value:Object):TextInputBuilder
    {
        PropertySetter.set(this.instance.textEditorProperties, "softKeyboardType", value);

        return this;
    }

    public function autoCapitalize(value:Object):TextInputBuilder
    {
        PropertySetter.set(this.instance.textEditorProperties, "autoCapitalize", value);

        return this;
    }
}
}
