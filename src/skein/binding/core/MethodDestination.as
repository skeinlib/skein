/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/30/13
 * Time: 2:08 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.core
{
public class MethodDestination implements Destination
{
    public function MethodDestination(site:Object, setter:String)
    {
        super();

        this.setter = setter;
    }

    private var setter:String;

    private var site:Object;

    public function setSite(site:Object):void
    {
        this.site = site;
    }

    public function getSite():Object
    {
        return this.site;
    }

    public function setValue(value:*):void
    {
        this.site[this.setter](value);
    }

    public function getMember():String
    {
        return "";
    }
}
}
