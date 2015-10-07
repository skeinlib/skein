/**
 * Created by Max Rozdobudko on 10/5/15.
 */
package skein.rest.cache.response
{
import flash.net.URLRequestHeader;

public class Headers
{
    public static function valueOf(headers:Array):Headers
    {
        var result:Headers = new Headers();

        for (var i:int = 0, n:int = headers != null ? headers.length : 0; i < n; i++)
        {
            var header:URLRequestHeader = headers[i];

            switch (header.name)
            {
                case ETag.NAME :

                    result.eTag = ETag.valueOf(header.value);

                    break;

                case Expires.NAME :

                    result.expires = Expires.valueOf(header.value);

                    break;

                case CacheControl.NAME :

                    result.cacheControl = CacheControl.valueOf(header.value);

                    break;
            }
        }

        return result;
    }

    public function Headers()
    {
        super();
    }

    public var eTag:ETag;

    public var expires:Expires;

    public var cacheControl:CacheControl;

    public var url:String;
}
}
