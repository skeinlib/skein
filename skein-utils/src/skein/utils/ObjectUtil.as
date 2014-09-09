/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 8/4/14
 * Time: 11:59 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.utils
{
import flash.utils.ByteArray;

public class ObjectUtil
{
    public static function copy(value:Object):Object
    {
        var buffer:ByteArray = new ByteArray();
        buffer.writeObject(value);
        buffer.position = 0;
        var result:Object = buffer.readObject();
        return result;
    }
}
}
