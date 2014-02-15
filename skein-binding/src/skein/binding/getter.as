package skein.binding
{
import skein.binding.core.MethodSource;
import skein.binding.core.PropertyDestination;

public function getter(site:Object, method:String):MethodSource
{
    return new MethodSource(site, method);
}
}