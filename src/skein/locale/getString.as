package skein.locale
{
import skein.locale.core.ResourceManager;

public function getString(bundle:String, key:String, params:Array=null):Object
{
    return ResourceManager.instance.getString(bundle, key, params);
}
}