package skein.locale
{
import skein.binding.core.MethodSource;
import skein.binding.core.Source;
import skein.locale.ResourceManager;

public function getString(bundle:String, key:String, params:Array = null):Source
{
    params ||= [];

    params.unshift(key);
    params.unshift(bundle);

    return new MethodSource(ResourceManager.instance, "getString()", params);

//    return ResourceManager.instance.getString(bundle, key, params);
}
}