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

    public static function substituteWithArguments(str: String, args: StringSubstituteArguments): String {
        return substitute(str, args.value);
    }

    public static function trim(str:String):String
    {
        if (str == null) return '';

        var startIndex:int = 0;
        while (isWhitespace(str.charAt(startIndex)))
            ++startIndex;

        var endIndex:int = str.length - 1;
        while (isWhitespace(str.charAt(endIndex)))
            --endIndex;

        if (endIndex >= startIndex)
            return str.slice(startIndex, endIndex + 1);
        else
            return "";
    }

    public static function isWhitespace(character:String):Boolean
    {
        switch (character)
        {
            case " ":
            case "\t":
            case "\r":
            case "\n":
            case "\f":
                return true;

            default:
                return false;
        }
    }
}
}
