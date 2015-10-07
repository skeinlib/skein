/**
 * Created by Max Rozdobudko on 10/2/15.
 */
package skein.rest.cache
{
import flash.net.URLRequest;

import skein.rest.cache.response.Headers;

public interface CacheClient
{
    function head(request:URLRequest):Headers;

    function live(request:URLRequest):Boolean;

    function find(request:URLRequest, callback:Function):void;

    function keep(request:URLRequest, data:Object, headers:Array, callback:Function = null):Boolean;
}
}
