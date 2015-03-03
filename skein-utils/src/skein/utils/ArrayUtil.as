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
    public static function equal(array1:Array, array2:Array):Boolean
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

    public static function same(array1:Array, array2:Array, comparator:Function=null):Boolean
    {
        if (array1 == null && array2 == null) return true;

        if (array1 == null || array2 == null) return false;

        if (array1.length != array2.length) return false;

        for (var i:uint = 0, n:uint = array1.length; i < n; i++)
        {
            var value1:Object = array1[i];

            var found:Boolean;

            if (comparator == null)
            {
                found = array2.indexOf(value1) != -1;
            }
            else
            {
                found = array2.some(function(value2:*, index:int, array:Array):Boolean
                {
                    return comparator(value1, value2);
                });
            }

            if (!found) return false;
        }

        return true;
    }

    public static function copy(array:Array):Array
    {
        if (array == null)
            return null;

        var result:Array = [];

        for (var i:uint = 0, n:uint = array.length; i < n; i++)
        {
            var item:Object = array[i];

            result.push(ObjectUtil.copy(item));
        }

        return result;
    }
}
}
