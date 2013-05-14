/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/20/13
 * Time: 11:34 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.mixins
{
import skein.components.builder.mixins.ElementContainerMixin;

import starling.display.DisplayObjectContainer;

public class FeathersElementContainerMixin implements ElementContainerMixin
{
    public function FeathersElementContainerMixin(instance:DisplayObjectContainer)
    {
        super();

        this.instance = instance;
    }

    private var instance:DisplayObjectContainer;

    public function contains(elements):void
    {
        for (var i:int = 0, n:int = elements.length; i < n; i++)
        {
            this.instance.addChild(elements[i]);
        }
    }
}
}
