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
    public static function compare(array1:ByteArray, array2:ByteArray):Boolean
    {
        if (array1 == null && array2 == null) return true;

        if (array1 == null || array2 == null) return false;

        if (array1.length != array2.length) return false;

        var n:uint = array1.length;
        while(array1.position < n)
        {
            var byte1:int = array1.readByte();
            var byte2:int = array2.readByte();

            if (byte1 != byte2) return false;
        }

        return true;
    }
}
}
