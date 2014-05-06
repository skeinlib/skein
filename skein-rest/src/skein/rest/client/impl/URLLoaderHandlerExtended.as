/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 3/28/14
 * Time: 12:57 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client.impl
{
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequestHeader;

import skein.rest.client.impl.URLLoaderHandlerAbstract;

import skein.rest.core.HeaderHandler;

public class URLLoaderHandlerExtended extends URLLoaderHandlerAbstract implements URLLoaderHandler
{
    public function URLLoaderHandlerExtended(client:DefaultRestClient)
    {
        super(client);
    }

    public function handle(loader:URLLoader):void
    {
        function resultHandler(event:Event):void
        {
            loader.removeEventListener(Event.COMPLETE, resultHandler);
            loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, statusHandler);
            loader.removeEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, responseStatusHandler);
            loader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
            loader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);

            if (responseCode >= 200 && responseCode < 300) // result
            {
                result(loader.data);
            }
            else // error
            {
                error(loader.data)
            }
        }

        function errorHandler(event:ErrorEvent):void
        {
            loader.removeEventListener(Event.COMPLETE, resultHandler);
            loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, statusHandler);
            loader.removeEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, responseStatusHandler);
            loader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
            loader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);

            error(loader.data);
        }

        function statusHandler(event:HTTPStatusEvent):void
        {
            status(event.status);
        }

        function responseStatusHandler(event:HTTPStatusEvent):void
        {
            for each (var header:URLRequestHeader in event.responseHeaders)
            {
                var callback:Function =
                    client.headerCallbacks[header.name] || HeaderHandler.forName(header.name);

                if (callback != null)
                {
                    callback.apply(null, [header]);
                }
            }
        }

        function progressHandler(event:ProgressEvent):void
        {
            progress(event.bytesLoaded, event.bytesTotal);
        }

        loader.addEventListener(Event.COMPLETE, resultHandler);
        loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, responseStatusHandler)
        loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, statusHandler);
        loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
        loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
        loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
    }
}
}
