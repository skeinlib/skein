/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/8/13
 * Time: 3:09 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.components
{
import feathers.controls.ImageLoader;

import skein.components.builder.components.ImageBuilder;
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

public class FeathersImageBuilder extends FeathersBuilder implements ImageBuilder
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function FeathersImageBuilder(host:Object, generator:Class = null)
    {
        super();

        this.host = host;

        createInstance(generator);

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

    private function get instance():ImageLoader
    {
        return _instance as ImageLoader;
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override protected function createInstance(generator:Class = null):void
    {
        this._instance = generator ? new generator() : new ImageLoader();
    }

    //------------------------------------
    //  Methods: Sprite
    //------------------------------------

    public function x(value:Object):ImageBuilder
    {
        spriteNature.x(value);

        return this;
    }

    public function y(value:Object):ImageBuilder
    {
        spriteNature.y(value);

        return this;
    }

    public function width(value:Object):ImageBuilder
    {
        spriteNature.width(value);

        return this;
    }

    public function height(value:Object):ImageBuilder
    {
        spriteNature.height(value);

        return this;
    }

    public function maxWidth(value:Object):ImageBuilder
    {
        spriteNature.maxWidth(value);

        return this;
    }

    public function maxHeight(value:Object):ImageBuilder
    {
        spriteNature.maxHeight(value);

        return this;
    }

    public function rotation(value:Object, axis:String = null):ImageBuilder
    {
        spriteNature.rotation(value, axis);

        return this;
    }

    public function visible(value:Object):ImageBuilder
    {
        spriteNature.visible(value);

        return this;
    }

    public function alpha(value:Object):ImageBuilder
    {
        spriteNature.alpha(value);

        return this;
    }

    public function z(value:Object):ImageBuilder
    {
        spriteNature.z(value);

        return this;
    }

    public function scale(value:Object, axis:String = null):ImageBuilder
    {
        spriteNature.scale(value, axis);

        return this;
    }

    public function mask(value:Object):ImageBuilder
    {
        spriteNature.mask(value);

        return this;
    }

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    public function on(type:String, handler:Function, weak:Boolean = true):ImageBuilder
    {
        eventDispatcherNature.on(type, handler, weak);

        return this;
    }

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    public function left(value:Object):ImageBuilder
    {
        layoutElementNature.left(value);

        return this;
    }

    public function top(value:Object):ImageBuilder
    {
        layoutElementNature.top(value);

        return this;
    }

    public function right(value:Object):ImageBuilder
    {
        layoutElementNature.right(value);

        return this;
    }

    public function bottom(value:Object):ImageBuilder
    {
        layoutElementNature.bottom(value);

        return this;
    }

    public function horizontalCenter(value:Object):ImageBuilder
    {
        layoutElementNature.horizontalCenter(value);

        return this;
    }

    public function verticalCenter(value:Object):ImageBuilder
    {
        layoutElementNature.verticalCenter(value);

        return this;
    }

    public function includeInLayout(value:Object):ImageBuilder
    {
        layoutElementNature.includeInLayout(value);

        return this;
    }

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    public function id(id:Object):ImageBuilder
    {
        this.instanceId = id;

        return this;
    }

    public function styleName(value:Object):ImageBuilder
    {
        componentNature.styleName(value);

        return this;
    }

    public function enabled(value:Object):ImageBuilder
    {
        componentNature.enabled(value);

        return this;
    }

    //-----------------------------------
    //  Methods: Image
    //-----------------------------------
    
    public function source(value:Object):ImageBuilder
    {
        PropertySetter.set(this.instance, "source", value);

        return this;
    }

    public function smooth(value:Object):ImageBuilder
    {
        PropertySetter.set(this.instance, "smoothing", value);

        return this;
    }

    public function fillMode(value:Object):ImageBuilder
    {
        return this;
    }

    public function scaleMode(value:Object):ImageBuilder
    {
        return this;
    }


}
}
