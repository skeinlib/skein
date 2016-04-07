/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 12:18 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.mixins
{
import feathers.core.IFeathersControl;

import skein.components.builder.mixins.ComponentMixin;
import skein.core.PropertySetter;

public class FeathersComponentNature implements ComponentMixin
{
    public function FeathersComponentNature(instance:IFeathersControl)
    {
        super();

        this.instance = instance;
    }

    private var host:Object;
    private var instance:IFeathersControl;

    public function enabled(value:Object):void
    {
        PropertySetter.set(this.instance, "isEnabled", value);
    }

    public function styleName(value:Object):void
    {
        PropertySetter.set(this.instance, "styleName", value);
    }
}
}
