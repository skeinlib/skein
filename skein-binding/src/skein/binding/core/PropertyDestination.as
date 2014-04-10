/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/30/13
 * Time: 2:05 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.core
{
import skein.core.Reference;
import skein.core.WeakReference;

public class PropertyDestination implements Destination
{
    public function PropertyDestination(site:Object, property:String)
    {
        super();

        this.site = new WeakReference(site);
        this.property = property;
    }

    private var site:Reference;
    private var property:String;

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
        try
        {
            getSite()[this.property] = value;
        }
        catch(error:Error)
        {
//            trace(error.getStackTrace());

            switch (error.errorID)
            {
                case 1009 :
                case 1010 :
                case 1055 :
                        // ignore
                    break;

                default :
                        throw error;
                    break;
            }
        }
    }
}
}
