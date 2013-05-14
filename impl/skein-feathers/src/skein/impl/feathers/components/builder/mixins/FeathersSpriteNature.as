/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 12:08 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.mixins
{
import skein.components.builder.mixins.SpriteMixin;
import skein.components.enum.Axis;
import skein.core.PropertySetter;

import starling.display.Sprite;

public class FeathersSpriteNature implements SpriteMixin
{
    public function FeathersSpriteNature(instance:Sprite)
    {
        super();

        this.instance = instance;
    }

    private var instance:Sprite;

    public function x(value:Object):void
    {
        PropertySetter.set(this.instance, "x", value);
    }

    public function y(value:Object):void
    {
        PropertySetter.set(this.instance, "y", value);
    }

    public function z(value:Object):void
    {
        // not supported
    }

    public function width(value:Object):void
    {
        PropertySetter.set(this.instance, "width", value);
    }

    public function height(value:Object):void
    {
        PropertySetter.set(this.instance, "height", value);
    }

    public function visible(value:Object):void
    {
        PropertySetter.set(this.instance, "visible", value);
    }

    public function alpha(value:Object):void
    {
        PropertySetter.set(this.instance, "alpha", value);
    }

    public function rotation(value:Object, axis:String = null):void
    {
        switch (axis)
        {
            case Axis.X : /* not supported */ break;
            case Axis.Y : /* not supported */ break;
            case Axis.Z : /* not supported */ break;
            default : PropertySetter.set(this.instance, "rotation", value); break;
        }
    }

    public function scale(value:Object, axis:String = null):void
    {
        switch (axis)
        {
            case Axis.X :
                PropertySetter.set(this.instance, "scaleX", value);
                break;

            case Axis.Y :
                PropertySetter.set(this.instance, "scaleY", value);
                break;

            case Axis.Z :
                /* not supported */
                break;

            default :
                PropertySetter.set(this.instance, "scaleX", value);
                PropertySetter.set(this.instance, "scaleY", value);
                break;
        }
    }

    public function mask(value:Object):void
    {
        // not supported
    }

    public function contains(...children):void
    {
        for (var i:int = 0, n:int = children.length; i < n; i++)
        {
            this.instance.addChild(children[i]);
        }
    }
}
}
