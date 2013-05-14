/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 12:54 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.components
{
import skein.impl.feathers.components.builder.components.*;

import feathers.layout.HorizontalLayout;

import skein.components.builder.components.HGroupBuilder;

public class FeathersHGroupBuilder extends FeathersGroupBuilder implements HGroupBuilder
{
    public function FeathersHGroupBuilder(host:Object)
    {
        super(host);
    }

    override protected function createInstance():void
    {
        super.createInstance();

        this.instance.layout = new HorizontalLayout();
    }
}
}
