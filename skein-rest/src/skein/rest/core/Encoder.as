/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/17/13
 * Time: 7:25 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.core
{
public class Encoder
{
    public static function forType(contentType:String):Function
    {
        if (contentType == "application/json")
            return JSONCoding.encode;
        else
            return unknown;
    }

    private static function unknown(data:Object, callback:Function):void
    {
        callback(data);
    }
}
}
