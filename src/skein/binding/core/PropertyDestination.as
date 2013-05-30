/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/30/13
 * Time: 2:05 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.core
{
import skein.utils.WeakReference;

public class PropertyDestination implements Destination
{
    public function PropertyDestination(site:Object, property:String)
    {
        super();

        this.site = new WeakReference(site);
        this.property = property;
    }

    private var site:Object;
    private var property:String;

    public function setSite(value:Object):void
    {
        this.site = value;
    }

    public function getSite():Object
    {
        return this.site.value;
    }

    public function getMember():String
    {
        return this.property;
    }

    public function setValue(value:*):void
    {
        this.site.value[this.property] = value;
    }
}
}
