/**
 * Created by Max Rozdobudko on 10/6/15.
 */
package skein.rest.core.coding
{
public class DefaultCoding
{
    public static function encode(data: Object, callback: Function):void {
        if (callback.length == 1) {
            callback(data);
        } else {
            callback();
        }
    }

    public static function decode(data: Object, callback: Function):void {
        if (callback.length == 1) {
            callback(data);
        } else {
            callback();
        }
    }
}
}
