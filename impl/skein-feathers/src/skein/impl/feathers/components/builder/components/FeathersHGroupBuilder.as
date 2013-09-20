/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 12:54 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.components
{
import feathers.layout.HorizontalLayout;

import skein.components.builder.components.HGroupBuilder;

public class FeathersHGroupBuilder extends FeathersGroupBuilder implements HGroupBuilder
{
    public function FeathersHGroupBuilder(host:Object, generator:Class = null)
    {
        super(host, generator);
    }

    override protected function createInstance(generator:Class = null):void
    {
        super.createInstance(generator);

        Object(instance).layout = new HorizontalLayout();
    }
}
}
