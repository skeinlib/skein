/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/18/13
 * Time: 11:37 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.core.coding
{
public class JSONCoding
{
    public static function encode(data:Object, callback:Function):void
    {
        callback(JSON.stringify(data));
    }

    public static function decode(json:String, callback:Function):void
    {
        var data:Object;

        data = JSON.parse(json);

        callback(data);
    }
}
}
