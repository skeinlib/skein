/**
 * Created by Max Rozdobudko on 10/2/15.
 */
package skein.rest.cache
{
import flash.net.URLRequest;

import skein.rest.cache.response.Head;

public interface CacheClient
{
    /**
     * Returns a head part of response if exists.
     *
     * @param request A request for which response should be found.
     * @return A <code>Head</code> instance if response for specified request
     * exists.
     */
    function head(request:URLRequest):Head;

    /**
     * Indicates if there is a response for specified request and it is fresh to
     * be used.
     *
     * @param request A request for which response should be found.
     * @return <code>true</code> if response exists and it is fresh or
     * <code>false</code> - otherwise.
     */
    function live(request:URLRequest):Boolean;

    /**
     * Retrieves <code>Response</code> from cache for specified request and
     * provides it into specified callback, if response doesn't exist the
     * <code>null</code> value will be provided.
     *
     * @param request A request for which response should be found.
     * @param callback A function that handles end of find operation, it should
     * have next signature:
     * function(response:Response):void;
     */
    function find(request:URLRequest, callback:Function):void;

    /**
     * Stores received data in cache and passes <code>Response</code> instance
     * for the stored data for the specified callback, if response can't be
     * stored it provides callback with <code>null</code> value.
     *
     * @param request A request that was used to obtain data.
     * @param data Received data
     * @param headers An array of response headers
     * @param callback A function with next signature: function(response:Response):void;
     * @return <code>true</code> if store process is successfully started or <code>false</code> if storing process can't be started.
     */
    function keep(request:URLRequest, data:Object, headers:Array, callback:Function = null):Boolean;

    /**
     * Clears all cache
     */
    function purge():void;
}
}
