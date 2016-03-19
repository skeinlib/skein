/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/15/13
 * Time: 1:44 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.mixins.impl
{
import skein.components.builder.mixins.ObjectNature;
import skein.core.PropertySetter;

public class DefaultObjectNature implements ObjectNature
{
    public function DefaultObjectNature(instance:Object)
    {
        super();

        this.instance = instance;
    }

    private var instance:Object;

    public function set(property:String, value:Object):void
    {
        PropertySetter.set(this.instance, property, value);
    }
}
}
