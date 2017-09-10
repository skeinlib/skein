/**
 * Created by Max Rozdobudko on 12/29/14.
 */
package skein.utils
{
public class DateUtil
{
    public static function same(date1:Date, date2:Date):Boolean
    {
        if (date1 == date2) return true;

        if (date1 == null && date2 == null) return true;

        if (date1 == null || date2 == null) return false;

        if (date1.time == date2.time) return true;

        return false;
    }


}
}
