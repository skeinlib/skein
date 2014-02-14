package skein.locale
{
import skein.binding.core.MethodSource;
import skein.binding.core.Source;
import skein.locale.ResourceManager;

public function getString(bundle:String, key:String, ...rest:Array):Source
{
    var params:Array = [bundle, key];

    if (rest && rest.length > 0)
        params.push(rest);

//    params ||= [];
//
//    params.unshift(key);
//    params.unshift(bundle);

    return new MethodSource(ResourceManager.instance, "getString()", params);

//    return ResourceManager.instance.getString(bundle, key, params);
}
}