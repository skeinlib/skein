package skein.binding
{
import skein.binding.core.PropertySource;
import skein.binding.core.SourceBase;

public function get(host:Object, property:String):SourceBase
{
    return new PropertySource(host, property);
}

}
