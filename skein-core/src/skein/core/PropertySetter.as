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
        var SourceClass:Class;
        var BindingContextClass:Class;

        try
        {
            SourceClass = getDefinitionByName("skein.binding.core::Source") as Class;
            BindingContextClass = getDefinitionByName("skein.binding.core::BindingContext") as Class;
        }
        catch (error:ReferenceError)
        {
            // No public definition exists with the specified name.
            // It's ok
        }
        catch (error:Error)
        {
            // It's strange, but ignore they too
        }

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
