/**
 * Created by Max Rozdobudko on 10/5/15.
 */
package skein.rest.cache.headers
{
import skein.rest.utils.DateUtil;

public class Expires
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    public static const NAME:String = "Expires";

    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    public static function valueOf(string:String):Expires
    {
        var expires:Expires = new Expires();

        expires.date = DateUtil.parseRFC822(string);

        return expires;
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Expires()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    public var date:Date;
}
}
