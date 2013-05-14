/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/20/13
 * Time: 10:49 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.layout
{
import feathers.layout.AnchorLayout;

import skein.components.builder.layout.LayoutBuilder;

public class FeathersLayoutBuilder implements LayoutBuilder
{
    public function FeathersLayoutBuilder()
    {
        super();

        this.instance = new AnchorLayout();
    }

    private var instance:AnchorLayout;

    public function addTo(host:Object = null):Object
    {
        host.layout = this.instance;

        return this.build();
    }

    public function build():Object
    {
        return this.instance;
    }
}
}
