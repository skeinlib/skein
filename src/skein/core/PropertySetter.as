/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/21/13
 * Time: 1:37 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.core
{
import skein.binding.core.BindingContext;
import skein.binding.core.PropertyDestination;
import skein.binding.core.Source;

public class PropertySetter
{
    public static function set(site:Object, property:String, value:Object):void
    {
        if (value is Source)
        {
            var ctx:BindingContext = new BindingContext();

            ctx.bind(Source(value), new PropertyDestination(site, property));
        }
        else
        {
            site[property] = value;
        }
    }
}
}
