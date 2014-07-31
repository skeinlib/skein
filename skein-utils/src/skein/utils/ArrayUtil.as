/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/3/14
 * Time: 1:57 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.utils
{
public class ArrayUtil
{
    public static function compare(array1:Array, array2:Array):Boolean
    {
        if (array1 == null && array2 == null) return true;

        if (array1 == null || array2 == null) return false;

        if (array1.length != array2.length) return false;

        for (var i:uint = 0, n:uint = array1.length; i < n; i++)
        {
            var value1:Object = array1[i];
            var value2:Object = array2[i];
            
            if (value1 != value2) return false;
        }
        
        return true;
    }

    public static function same(array1:Array, array2:Array):Boolean
    {
        if (array1 == null && array2 == null) return true;

        if (array1 == null || array2 == null) return false;

        if (array1.length != array2.length) return false;

        for (var i:uint = 0, n:uint = array1.length; i < n; i++)
        {
            var value1:Object = array1[i];

            if (array2.indexOf(value1) == -1) return false;
        }

        return true;
    }
}
}
