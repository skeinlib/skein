/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 3/25/14
 * Time: 11:02 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.utils
{
import flash.utils.ByteArray;

public class ByteArrayUtil
{
    public static function compare(ba1:ByteArray, ba2:ByteArray):Boolean
    {
        if (ba1 == null && ba2 == null) return true;

        if (ba1 == null || ba2 == null) return false;

        if (ba1.length != ba2.length) return false;

        while (ba1.bytesAvailable)
        {
            if (!compareBytes(ba1, ba2, 32))
            {
                return false;
            }
        }

        return true;
    }

    private static function compareBytes(ba1:ByteArray, ba2:ByteArray, length:int):Boolean
    {
        var string1:String = ba1.readUTFBytes(Math.max(ba1.bytesAvailable, length));
        var string2:String = ba2.readUTFBytes(Math.max(ba2.bytesAvailable, length));

        return string1 == string2;
    }

    public static function bytes(ba1:ByteArray, ba2:ByteArray):Boolean
    {
        if (ba1 == null && ba2 == null) return true;

        if (ba1 == null || ba2 == null) return false;

        if (ba1.length != ba2.length) return false;

        while (ba1.bytesAvailable) {
            if (ba1.readByte() != ba2.readByte()) {
                return false;
            }
        }

        return true;
    }
}
}
