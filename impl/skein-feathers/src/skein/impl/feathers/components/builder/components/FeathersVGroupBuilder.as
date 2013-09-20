/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 12:52 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.components
{
import feathers.layout.VerticalLayout;

import skein.components.builder.components.VGroupBuilder;

public class FeathersVGroupBuilder extends FeathersGroupBuilder implements VGroupBuilder
{
    public function FeathersVGroupBuilder(host:Object, generator:Class = null)
    {
        super(host, generator);
    }

    override protected function createInstance(generator:Class = null):void
    {
        super.createInstance(generator);

        Object(instance).layout = new VerticalLayout();
    }
}
}
