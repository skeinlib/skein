/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 3/28/14
 * Time: 1:00 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client.impl
{
import flash.events.HTTPStatusEvent;

import skein.rest.core.Config;

import skein.rest.core.HeaderHandler;

public class URLLoaderHandlerFactory
{
    public static function create(client:DefaultRestClient):URLLoaderHandler
    {
        if (client.hasHeaderCallbacks() || HeaderHandler.hasHandlers())
        {
            if (HTTPStatusEvent.HTTP_RESPONSE_STATUS)
                return new URLLoaderHandlerExtended(client);
        }

        return new URLLoaderHandlerStandard(client);
    }
}
}
