/**
 * Created by Max Rozdobudko on 4/10/15.
 */
package skein.utils
{
public class VectorUtil
{
    public static function toArray(vector:*):Array
    {
        if (vector == null) return null;

        var result:Array = [];

        for (var i:int = 0, n:int = vector.length; i < n; i++)
        {
            result[i] = vector[i];
        }

        return result;
    }

    public static function fromArray(array:Array, vector:*):void
    {
        if (array == null) return;

        for (var i:int = 0; i < array.length; i++)
        {
            vector[i] = array[i];
        }
    }

    public static function equals(vector1:*, vector2:*):Boolean
    {
        if (vector1 == vector2) return true;

        if (vector1 == null && vector2 == null) return true;

        if (vector1 == null || vector2 == null) return false;

        if (vector1.length != vector2.length) return false;

        for (var i:int = 0; i < vector1.length; i++)
        {
            if (vector1[i] != vector2[i])
                return false;
        }

        return true;
    }

    public static function same(vector1:*, vector2:*, comparator:Function=null):Boolean
    {
        if (vector1 == vector2) return true;

        if (vector1 == null && vector2 == null) return true;

        if (vector1 == null || vector2 == null) return false;

        if (vector1.length != vector2.length) return false;

        for (var i:uint = 0, n:uint = vector1.length; i < n; i++)
        {
            var value1:Object = vector1[i];

            var found:Boolean;

            if (comparator == null)
            {
                found = vector2.indexOf(value1) != -1;
            }
            else
            {
                found = vector2.some(function(value2:*, index:int, array:Array):Boolean
                {
                    return comparator(value1, value2);
                });
            }

            if (!found) return false;
        }

        return true;
    }
}
}
