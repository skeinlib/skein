/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/10/13
 * Time: 2:04 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.components
{
import feathers.controls.TextArea;

import skein.components.builder.components.TextAreaBuilder;
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

public class FeathersTextAreaBuilder extends FeathersBuilder implements TextAreaBuilder
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function FeathersTextAreaBuilder(host:Object, generator:Class=null)
    {
        super();

        this.host = host;
        createInstance(generator);

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

    private function get instance():TextArea
    {
        return _instance as TextArea;
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override protected function createInstance(generator:Class = null):void
    {
        this._instance =  new TextArea();
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  Methods: Sprite
    //------------------------------------

    public function x(value:Object):TextAreaBuilder
    {
        spriteMixin.x(value);

        return this;
    }

    public function y(value:Object):TextAreaBuilder
    {
        spriteMixin.y(value);

        return this;
    }

    public function width(value:Object):TextAreaBuilder
    {
        spriteMixin.width(value);

        return this;
    }

    public function height(value:Object):TextAreaBuilder
    {
        spriteMixin.height(value);

        return this;
    }

    public function rotation(value:Object, axis:String = null):TextAreaBuilder
    {
        spriteMixin.rotation(value, axis);

        return this;
    }

    public function visible(value:Object):TextAreaBuilder
    {
        spriteMixin.visible(value);

        return this;
    }

    public function alpha(value:Object):TextAreaBuilder
    {
        spriteMixin.alpha(value);

        return this;
    }

    public function z(value:Object):TextAreaBuilder
    {
        spriteMixin.z(value);

        return this;
    }

    public function scale(value:Object, axis:String = null):TextAreaBuilder
    {
        spriteMixin.scale(value, axis);

        return this;
    }

    public function mask(value:Object):TextAreaBuilder
    {
        spriteMixin.mask(value);

        return this;
    }

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    public function on(type:String, handler:Function, weak:Boolean = true):TextAreaBuilder
    {
        eventDispatcherMixin.on(type, handler, weak);

        return this;
    }

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    public function left(value:Object):TextAreaBuilder
    {
        layoutElementMixin.left(value);

        return this;
    }

    public function top(value:Object):TextAreaBuilder
    {
        layoutElementMixin.top(value);

        return this;
    }

    public function right(value:Object):TextAreaBuilder
    {
        layoutElementMixin.right(value);

        return this;
    }

    public function bottom(value:Object):TextAreaBuilder
    {
        layoutElementMixin.bottom(value);

        return this;
    }

    public function horizontalCenter(value:Object):TextAreaBuilder
    {
        layoutElementMixin.horizontalCenter(value);

        return this;
    }

    public function verticalCenter(value:Object):TextAreaBuilder
    {
        layoutElementMixin.verticalCenter(value);

        return this;
    }

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    public function id(id:Object):TextAreaBuilder
    {
        this.instanceId = id;

        return this;
    }

    public function styleName(value:Object):TextAreaBuilder
    {
        componentMixin.styleName(value);

        return this;
    }

    public function enabled(value:Object):TextAreaBuilder
    {
        componentMixin.enabled(value);

        return this;
    }

    //-----------------------------------
    //  Methods: TextArea
    //-----------------------------------

    public function text(value:Object):TextAreaBuilder
    {
        PropertySetter.set(this.instance, "text", value);

        return this;
    }

    public function restrict(value:Object):TextAreaBuilder
    {
        PropertySetter.set(this.instance.textEditorProperties, "restrict", value);

        return this;
    }


    public function editable(value:Object):TextAreaBuilder
    {
        PropertySetter.set(this.instance, "isEditable", value);

        return this;
    }

    public function maxChars(value:Object):TextAreaBuilder
    {
        PropertySetter.set(this.instance, "maxChars", value);

        return this;
    }

    public function softKeyboardType(value:Object):TextAreaBuilder
    {
        PropertySetter.set(this.instance.textEditorProperties, "softKeyboardType", value);

        return this;
    }

    public function autoCapitalize(value:Object):TextAreaBuilder
    {
        PropertySetter.set(this.instance.textEditorProperties, "autoCapitalize", value);

        return this;
    }
}
}
