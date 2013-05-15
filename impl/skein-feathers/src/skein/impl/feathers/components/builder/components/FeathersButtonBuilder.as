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
import skein.components.builder.mixins.ObjectNature;
import skein.components.builder.mixins.SpriteMixin;
import skein.components.builder.mixins.impl.DefaultObjectNature;
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

        this.objectNature = new DefaultObjectNature(this.instance);
        this.spriteNature = new FeathersSpriteNature(this.instance);
        this.componentNature = new FeathersComponentNature(this.instance);
        this.layoutElementNature = new FeathersLayoutElementNature(this.instance);
        this.eventDispatcherNature = new FeathersEventDispatcherNature(this.instance);
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Variables: Mixins
    //-------------------------------------

    private var objectNature:ObjectNature;

    private var spriteNature:SpriteMixin;

    private var componentNature:ComponentMixin;

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
    //  Methods: Object
    //------------------------------------

    public function set(property:String, value:Object):ButtonBuilder
    {
        objectNature.set(property, value);

        return this;
    }

    //------------------------------------
    //  Methods: Sprite
    //------------------------------------

    public function x(value:Object):ButtonBuilder
    {
        spriteNature.x(value);

        return this;
    }

    public function y(value:Object):ButtonBuilder
    {
        spriteNature.y(value);

        return this;
    }

    public function width(value:Object):ButtonBuilder
    {
        spriteNature.width(value);

        return this;
    }

    public function height(value:Object):ButtonBuilder
    {
        spriteNature.height(value);

        return this;
    }

    public function rotation(value:Object, axis:String = null):ButtonBuilder
    {
        spriteNature.rotation(value, axis);

        return this;
    }

    public function visible(value:Object):ButtonBuilder
    {
        spriteNature.visible(value);

        return this;
    }

    public function alpha(value:Object):ButtonBuilder
    {
        spriteNature.alpha(value);

        return this;
    }

    public function z(value:Object):ButtonBuilder
    {
        spriteNature.z(value);

        return this;
    }

    public function scale(value:Object, axis:String = null):ButtonBuilder
    {
        spriteNature.scale(value, axis);

        return this;
    }

    public function mask(value:Object):ButtonBuilder
    {
        spriteNature.mask(value);

        return this;
    }

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    public function on(type:String, handler:Function, weak:Boolean = true):ButtonBuilder
    {
        eventDispatcherNature.on(type, handler, weak);

        return this;
    }

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    public function left(value:Object):ButtonBuilder
    {
        layoutElementNature.left(value);

        return this;
    }

    public function top(value:Object):ButtonBuilder
    {
        layoutElementNature.top(value);

        return this;
    }

    public function right(value:Object):ButtonBuilder
    {
        layoutElementNature.right(value);

        return this;
    }

    public function bottom(value:Object):ButtonBuilder
    {
        layoutElementNature.bottom(value);

        return this;
    }

    public function horizontalCenter(value:Object):ButtonBuilder
    {
        layoutElementNature.horizontalCenter(value);

        return this;
    }

    public function verticalCenter(value:Object):ButtonBuilder
    {
        layoutElementNature.verticalCenter(value);

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
        componentNature.styleName(value);

        return this;
    }

    public function enabled(value:Object):ButtonBuilder
    {
        componentNature.enabled(value);

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
