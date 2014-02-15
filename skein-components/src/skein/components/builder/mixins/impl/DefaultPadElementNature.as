/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/30/13
 * Time: 3:21 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.mixins.impl
{
import skein.components.builder.mixins.PadElementNature;
import skein.core.PropertySetter;

public class DefaultPadElementNature implements PadElementNature
{
    public function DefaultPadElementNature(instance:Object)
    {
        super();

        this.instance = instance;
    }

    private var instance:Object;

    public function padding(value:Object):void
    {
        PropertySetter.set(instance, "paddingLeft", value);
        PropertySetter.set(instance, "paddingTop", value);
        PropertySetter.set(instance, "paddingRight", value);
        PropertySetter.set(instance, "paddingBottom", value);
    }

    public function paddingLeft(value:Object):void
    {
        PropertySetter.set(instance, "paddingLeft", value);
    }

    public function paddingTop(value:Object):void
    {
        PropertySetter.set(instance, "paddingTop", value);
    }

    public function paddingRight(value:Object):void
    {
        PropertySetter.set(instance, "paddingRight", value);
    }

    public function paddingBottom(value:Object):void
    {
        PropertySetter.set(instance, "paddingBottom", value);
    }
}
}
