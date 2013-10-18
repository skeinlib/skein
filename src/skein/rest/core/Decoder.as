/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/18/13
 * Time: 11:36 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.core
{
public class Decoder
{
    public static function forType(contentType:String):Function
    {
        if (contentType == "application/json")
            return JSONCoding.decode;
        else
            return unknown;
    }

    private static function unknown(data:Object, callback:Function):void
    {
        callback(data);
    }
}
}
