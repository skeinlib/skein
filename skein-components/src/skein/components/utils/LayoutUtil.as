/**
 * Created by max on 4/5/16.
 */
package skein.components.utils
{
public class LayoutUtil
{
    private static const PERCENTAGE_VALUE_PATTERN:RegExp = /(\d+)%/;

    public static function isPercentageValue(value:Object):Boolean
    {
        return value is String ? PERCENTAGE_VALUE_PATTERN.test(value as String) : false
    }

    public static function extractPercentageValue(value:Object):Number
    {
        if (value is String)
        {
            var results:Array = PERCENTAGE_VALUE_PATTERN.exec(value as String);

            if (results.length > 1)
            {
                return results[1];
            }
            else
            {
                return NaN;
            }
        }
        else
        {
            return NaN;
        }
    }
}
}
