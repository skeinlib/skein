package skein.binding
{
import skein.binding.core.PropertyDestination;

public function getter(site:Object, property:String):PropertyDestination
{
    return new PropertyDestination(site, property);
}
}