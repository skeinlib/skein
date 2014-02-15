/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/21/13
 * Time: 1:37 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.core
{
import flash.utils.getDefinitionByName;

public class PropertySetter
{
    public static function set(site:Object, property:String, value:Object):void
    {
        var SourceClass:Class = getDefinitionByName("skein.binding.core::Source") as Class;
        var BindingContextClass:Class = getDefinitionByName("skein.binding.core::BindingContext") as Class;

        if (SourceClass && BindingContextClass && value is SourceClass)
        {
            BindingContextClass["bindProperty"](site, property, value);
        }
        else
        {
            site[property] = value;
        }
    }
}
}
