package skein.binding
{
import skein.binding.core.PropertyDestination;

public function set(site:Object, property:String):PropertyDestination
{
    return new PropertyDestination(site, property);
}
}