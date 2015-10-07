/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/18/13
 * Time: 11:36 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.core
{
import skein.rest.core.coding.DefaultCoding;
import skein.rest.core.coding.JSONCoding;
import skein.rest.core.coding.WWWFormCoding;

public class Decoder
{
    public static function forType(contentType:String):Function
    {
        switch (contentType)
        {
            case "application/json" :
                return JSONCoding.decode;
                break;

            case "application/x-www-form-urlencoded" :
                return WWWFormCoding.decode;
                break;

            default :
                return DefaultCoding.decode;
            break;
        }
    }
}
}
