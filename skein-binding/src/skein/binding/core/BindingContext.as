/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/21/13
 * Time: 2:27 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.core
{
import skein.core.skein_internal;

use namespace skein_internal;

public class BindingContext
{
    public static function bindProperty(site:Object, property:String, value:Object):void
    {
        var ctx:BindingContext = new BindingContext();

        ctx.bind(Source(value), new PropertyDestination(site, property));
    }

    public function bind(source:Source, destination:Destination):Binding
    {
        var binding:Binding = new Binding(source, destination);

        binding.install();

        binding.execute();

        return binding;
    }
}
}
