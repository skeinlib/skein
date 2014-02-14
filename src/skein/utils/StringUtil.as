/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 2/14/14
 * Time: 8:14 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.utils
{
public class StringUtil
{
    public static function substitute(str:String, ... rest):String
    {
        if (str == null) return '';

        // Replace all of the parameters in the msg string.
        var len:uint = rest.length;
        var args:Array;
        if (len == 1 && rest[0] is Array)
        {
            args = rest[0] as Array;
            len = args.length;
        }
        else
        {
            args = rest;
        }

        for (var i:int = 0; i < len; i++)
        {
            str = str.replace(new RegExp("\\{"+i+"\\}", "g"), args[i]);
        }

        return str;
    }
}
}
