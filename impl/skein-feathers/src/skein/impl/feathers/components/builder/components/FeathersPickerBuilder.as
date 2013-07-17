/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/16/13
 * Time: 6:18 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.components
{
import feathers.controls.PickerList;

import skein.components.builder.components.PickerBuilder;
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

public class FeathersPickerBuilder extends FeathersBuilder implements PickerBuilder
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function FeathersPickerBuilder(host:Object, generator:Class=null)
    {
        super();

        this.host = host;
        this._instance = generator ? new generator() : new PickerList();

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

    private function get instance():PickerList
    {
        return _instance as PickerList;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  Methods: Sprite
    //------------------------------------

    public function x(value:Object):PickerBuilder
    {
        spriteMixin.x(value);

        return this;
    }

    public function y(value:Object):PickerBuilder
    {
        spriteMixin.y(value);

        return this;
    }

    public function width(value:Object):PickerBuilder
    {
        spriteMixin.width(value);

        return this;
    }

    public function height(value:Object):PickerBuilder
    {
        spriteMixin.height(value);

        return this;
    }

    public function rotation(value:Object, axis:String = null):PickerBuilder
    {
        spriteMixin.rotation(value, axis);

        return this;
    }

    public function visible(value:Object):PickerBuilder
    {
        spriteMixin.visible(value);

        return this;
    }

    public function alpha(value:Object):PickerBuilder
    {
        spriteMixin.alpha(value);

        return this;
    }

    public function z(value:Object):PickerBuilder
    {
        spriteMixin.z(value);

        return this;
    }

    public function scale(value:Object, axis:String = null):PickerBuilder
    {
        spriteMixin.scale(value, axis);

        return this;
    }

    public function mask(value:Object):PickerBuilder
    {
        spriteMixin.mask(value);

        return this;
    }

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    public function on(type:String, handler:Function, weak:Boolean = true):PickerBuilder
    {
        eventDispatcherMixin.on(type, handler, weak);

        return this;
    }

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    public function left(value:Object):PickerBuilder
    {
        layoutElementMixin.left(value);

        return this;
    }

    public function top(value:Object):PickerBuilder
    {
        layoutElementMixin.top(value);

        return this;
    }

    public function right(value:Object):PickerBuilder
    {
        layoutElementMixin.right(value);

        return this;
    }

    public function bottom(value:Object):PickerBuilder
    {
        layoutElementMixin.bottom(value);

        return this;
    }

    public function horizontalCenter(value:Object):PickerBuilder
    {
        layoutElementMixin.horizontalCenter(value);

        return this;
    }

    public function verticalCenter(value:Object):PickerBuilder
    {
        layoutElementMixin.verticalCenter(value);

        return this;
    }

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    public function id(id:Object):PickerBuilder
    {
        this.instanceId = id;

        return this;
    }

    public function styleName(value:Object):PickerBuilder
    {
        componentMixin.styleName(value);

        return this;
    }

    public function enabled(value:Object):PickerBuilder
    {
        componentMixin.enabled(value);

        return this;
    }

    //-----------------------------------
    //  Methods: List
    //-----------------------------------

    public function provider(value:Object):PickerBuilder
    {
        PropertySetter.set(this.instance, "dataProvider", value);

        return this;
    }

    public function item(value:Object):PickerBuilder
    {
        PropertySetter.set(this.instance, "selectedItem", value);

        return this;
    }

    public function index(value:Object):PickerBuilder
    {
        PropertySetter.set(this.instance, "selectedIndex", value);

        return this;
    }

    // TODO: Consider support for binding
    public function renderer(value:Object):PickerBuilder
    {
        if (value is Function)
        {
            this.instance.listProperties.itemRendererFactory = value as Function;
        }
        else if (value is Class)
        {
            this.instance.listProperties.itemRendererType = value as Class;
        }

        return this;
    }

    public function labelField(value:Object):PickerBuilder
    {
        PropertySetter.set(this.instance, "labelField", value);

        return this;
    }

    public function labelFunction(value:Object):PickerBuilder
    {
        PropertySetter.set(this.instance, "labelFunction", value);

        return this;
    }

    public function typicalItem(value:Object):PickerBuilder
    {
        PropertySetter.set(this.instance, "typicalItem", value);

        return this;
    }

    //-----------------------------------
    //  Methods: PickerList
    //-----------------------------------

    public function prompt(value:Object):PickerBuilder
    {
        PropertySetter.set(this.instance, "prompt", value);

        return this;
    }

    public function popupManager(value:Object):PickerBuilder
    {
        PropertySetter.set(this.instance, "popUpContentManager", value);

        return this;
    }
}
}
