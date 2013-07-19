/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/30/13
 * Time: 2:08 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.core
{
import skein.utils.WeakReference;

public class MethodDestination implements Destination
{
    public function MethodDestination(site:Object, setter:String)
    {
        super();

        this.site = new WeakReference(site);
        this.setter = setter;
    }

    private var setter:String;

    private var site:Object;

    public function getSite():Object
    {
        return this.site.value;
    }

    public function setValue(value:*):void
    {
        this.site.value[this.setter](value);
    }

    public function getMember():String
    {
        return setter;
    }
}
}
