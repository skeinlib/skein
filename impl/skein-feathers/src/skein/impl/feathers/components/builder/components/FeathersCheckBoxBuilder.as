/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/24/13
 * Time: 5:00 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.components
{
import feathers.controls.Check;

import skein.components.builder.components.CheckBoxBuilder;

public class FeathersCheckBoxBuilder extends FeathersButtonBuilder implements CheckBoxBuilder
{
    public function FeathersCheckBoxBuilder(host:Object)
    {
        super(host);
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override protected function createInstance():void
    {
        this._instance = new Check();
    }
}
}
