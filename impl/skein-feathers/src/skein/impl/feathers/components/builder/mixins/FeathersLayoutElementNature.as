/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/20/13
 * Time: 11:04 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.mixins
{
import feathers.layout.AnchorLayoutData;
import feathers.layout.ILayoutDisplayObject;

import skein.components.builder.mixins.LayoutElementMixin;
import skein.core.PropertySetter;

public class FeathersLayoutElementNature implements LayoutElementMixin
{
    public function FeathersLayoutElementNature(instance:ILayoutDisplayObject)
    {
        super();

        this.instance = instance;
        this.instance.layoutData = new AnchorLayoutData();

        this.layoutData = this.instance.layoutData as AnchorLayoutData;
    }

    private var instance:ILayoutDisplayObject;

    private var layoutData:AnchorLayoutData;

    public function left(value:Object):void
    {
        PropertySetter.set(this.layoutData, "left", value);
    }

    public function top(value:Object):void
    {
        PropertySetter.set(this.layoutData, "top", value);
    }

    public function right(value:Object):void
    {
        PropertySetter.set(this.layoutData, "right", value);
    }

    public function bottom(value:Object):void
    {
        PropertySetter.set(this.layoutData, "bottom", value);
    }

    public function horizontalCenter(value:Object):void
    {
        PropertySetter.set(this.layoutData, "horizontalCenter", value);
    }

    public function verticalCenter(value:Object):void
    {
        PropertySetter.set(this.layoutData, "verticalCenter", value);
    }

    public function includeInLayout(value:Object):void
    {
        PropertySetter.set(this.instance, "includeInLayout", value);
    }
}
}
