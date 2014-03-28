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

import skein.rest.core.HeaderHandler;

public class URLLoaderHandlerExtended implements URLLoaderHandler
{
    public function URLLoaderHandlerExtended(client:DefaultRestClient)
    {
        super();

        this.client = client;
    }

    private var client:DefaultRestClient;

    private var responseCode:int;

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
                if (client.resultCallback != null)
                {
                    client.decodeResult(loader.data,
                        function(data:Object):void
                        {
                            if (client.resultCallback.length == 2)
                                client.resultCallback(data, responseCode);
                            else
                                client.resultCallback(data);

                            client.free();
                        }
                    );
                }
                else
                {
                    client.free();
                }
            }
            else // error
            {
                if (client.errorCallback != null)
                {
                    client.decodeError(loader.data,
                        function(info:Object):void
                        {
                            if (client.errorCallback.length == 2)
                                client.errorCallback(info, responseCode);
                            else
                                client.errorCallback(info);

                            client.free();
                        }
                    );
                }
                else
                {
                    client.free();
                }
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

            if (client.errorCallback != null)
            {
                client.decodeError(loader.data,
                    function(info:Object):void
                    {
                        if (client.errorCallback.length == 2)
                            client.errorCallback(info, responseCode);
                        else
                            client.errorCallback(info);

                        client.free();
                    }
                );
            }
            else
            {
                client.free();
            }
        }

        function statusHandler(event:HTTPStatusEvent):void
        {
            responseCode = event.status;

            if (client.statusCallback != null)
                client.statusCallback(event.status);
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
            if (client.progressCallback != null)
                client.progressCallback(event.bytesLoaded, event.bytesTotal);
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
