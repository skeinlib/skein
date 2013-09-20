/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/25/13
 * Time: 11:09 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.components
{
import skein.components.builder.components.ChildrenBuilder;
import skein.components.builder.components.GroupBuilder;

import starling.display.DisplayObjectContainer;

public class FeathersChildrenBuilder implements ChildrenBuilder
{
    public function FeathersChildrenBuilder(host:Object, parent:GroupBuilder, container:DisplayObjectContainer)
    {
        super();

        this.host = host;

        this.parent = parent;

        this.container = container;
    }

    private var host:Object;

    private var container:DisplayObjectContainer;

    private var parent:GroupBuilder;

    public function build():GroupBuilder
    {
        return parent;
    }
}
}
