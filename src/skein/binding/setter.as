package skein.binding
{
import skein.binding.core.MethodDestination;

public function setter(site:Object, method:String):MethodDestination
{
    return new MethodDestination(site, method);
}
}