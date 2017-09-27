/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/22/14
 * Time: 1:05 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.core.coding
{
public class WWWFormCoding
{
    public static function encode(data:Object, callback:Function):void
    {
        var pairs:Array = [];

        if ("toJSON" in data) {
            data = data.toJSON(undefined);
        }

        for (var property:String in data) {
            pairs.push(property + "=" + data[property]);
        }

        callback(pairs.join("&"));
    }

    public static function decode(encoded:String, callback:Function):void
    {
        var data:Object = {};

        try
        {
            var pairs:Array = encoded.split("&");

            for each (var string:String in pairs)
            {
                var pair:Array = string.split("=");

                data[pair[0]] = pair[1];
            }
        }
        catch (error:Error)
        {
            trace("[skein-rest] WWWFormCoding:", error);

            data = encoded;
        }

        callback(data);
    }
}
}
