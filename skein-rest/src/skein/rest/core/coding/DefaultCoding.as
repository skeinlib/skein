/**
 * Created by Max Rozdobudko on 10/6/15.
 */
package skein.rest.core.coding
{
public class DefaultCoding
{
    public static function encode(data:Object, callback:Function):void
    {
        callback(data);
    }

    public static function decode(data:Object, callback:Function):void
    {
        callback(data);
    }
}
}
