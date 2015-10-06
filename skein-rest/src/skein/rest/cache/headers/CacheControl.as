/**
 * Created by Max Rozdobudko on 10/5/15.
 */
package skein.rest.cache.headers
{
public class CacheControl
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    public static const NAME:String = "Cache-Control";

    public static const CACHE_CONTROL_PUBLIC:String = "public";
    public static const CACHE_CONTROL_PRIVATE:String = "private";

    public static const CACHE_CONTROL_NO_CACHE:String = "no-cache";
    public static const CACHE_CONTROL_NO_STORE:String = "no-store";
    public static const CACHE_CONTROL_MUST_REVALIDATE:String = "must-revalidate";
    public static const CACHE_CONTROL_MAX_AGE:String = "max-age";
    public static const CACHE_CONTROL_NO_TRANSFORM:String = "no-transform";

    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    public static function valueOf(string:String):CacheControl
    {
        var cc:CacheControl = new CacheControl();

        string = string.replace(/\s*/g, "");

        var directives:Object = {};

        var field:String;
        var value:Object;

        var fieldStartIndex:int, fieldEndIndex:int, valueStartIndex:int, valueEndIndex:int;

        var i:int;
        while ((i = string.indexOf("=")) != -1)
        {
            var nameStartIndex:int = string.lastIndexOf(",", i);

            nameStartIndex = nameStartIndex != -1 ? nameStartIndex + 1 : 0;

            field = string.substring(nameStartIndex, i);

            if (string.charAt(i + 1) == '"')
            {
                valueStartIndex = i + 1;
                valueEndIndex = string.indexOf('"', valueStartIndex + 1) + 1;
            }
            else
            {
                valueStartIndex = i + 1;
                valueEndIndex = string.indexOf(",", i);
                valueEndIndex = valueEndIndex != -1 ? valueEndIndex : string.length;
            }

            value = string.substring(valueStartIndex, valueEndIndex).replace(/"/g, "").split(",");

            directives[field] = value;

            string = string.replace(string.substring(nameStartIndex, valueEndIndex), "");
        }

        for each (field in string.split(","))
        {
            if (field)
            {
                directives[field] = true;
            }
        }

        cc.isPublic = directives[CACHE_CONTROL_PUBLIC];
        cc.isPrivate = directives[CACHE_CONTROL_PRIVATE];
        cc.noCache = directives[CACHE_CONTROL_NO_CACHE];
        cc.noStore = directives[CACHE_CONTROL_NO_STORE];
        cc.noTransform = directives[CACHE_CONTROL_NO_TRANSFORM];
        cc.mustRevalidate = directives[CACHE_CONTROL_MUST_REVALIDATE];
        cc.maxAge = directives[CACHE_CONTROL_MAX_AGE];

        if (directives[CACHE_CONTROL_NO_CACHE] is Array)
            cc.noCacheFields = directives[CACHE_CONTROL_NO_CACHE];

        if (directives[CACHE_CONTROL_PRIVATE] is Array)
            cc.privateFields = directives[CACHE_CONTROL_PRIVATE];

        return cc;
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function CacheControl()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    public var isPrivate:Boolean;

    public var isPublic:Boolean;

    public var noCache:Boolean;

    public var noStore:Boolean;

    public var noTransform:Boolean;

    public var mustRevalidate:Boolean;

    public var maxAge:Number;

    public var noCacheFields:Array;

    public var privateFields:Array;
}
}
