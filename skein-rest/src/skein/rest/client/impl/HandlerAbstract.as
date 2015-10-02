/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/6/14
 * Time: 10:35 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client.impl
{
import flash.net.URLRequestHeader;

import skein.core.skein_internal;
import skein.rest.core.HeaderHandler;
import skein.rest.errors.DataProcessingError;

use namespace skein_internal;
public class HandlerAbstract
{
    public function HandlerAbstract(client:DefaultRestClient)
    {
        super();

        this.client = client;
    }

    protected var client:DefaultRestClient;

    protected var responseCode:int;

    protected var attempts:uint;

    protected var responseHeaders:Array;

    protected function dispose():void
    {
        client.free()
    }

    protected function status(code:int):void
    {
        responseCode = code;

        if (client.statusCallback != null)
            client.statusCallback(code);
    }

    protected function headers(headers:Array):void
    {
        responseHeaders = headers;

        for each (var header:URLRequestHeader in responseHeaders)
        {
            switch (header.name.toLowerCase())
            {
                case "content-type" :
                    client.setResponseContentType(header.value);
                    break;
            }

            var callback:Function =
                client.headerCallbacks[header.name] || HeaderHandler.forName(header.name);

            if (callback != null)
            {
                callback.apply(null, [header]);
            }
        }
    }

    protected function progress(loaded:Number, total:Number):void
    {
        if (client.progressCallback != null)
            client.progressCallback(loaded, total);
    }

    protected function result(data:Object):void
    {
        // indicates if result callback was called before an exception occurred
        var wasHandlerCalledBeforeError:Boolean = false;

        try
        {
            client.decodeResult(data,
                function(value:Object):void
                {
                    wasHandlerCalledBeforeError = true;

                    if (value is Error)
                    {
                        handleError(value);
                    }
                    else
                    {
                        handleResult(value);
                    }
                });
        }
        catch (error:Error)
        {
            // ignore the result already handled
            if (!wasHandlerCalledBeforeError)
            {
                trace(error);
                handleError(new DataProcessingError("An incorrect or invalid data was received."));
            }
        }
    }

    protected function handleResult(value:Object):void
    {
        client.handleResult(value, responseCode, responseHeaders);

        dispose();
    }

    protected function error(data:Object):void
    {
        client.decodeError(data, handleError);
    }

    protected function handleError(info:Object):void
    {
        if (client.errorInterceptor != null)
        {
            interceptError(info);
        }
        else if (client.errorCallback != null)
        {
            proceedError(info);
        }
        else
        {
            dispose();
        }
    }

    private function interceptError(info:Object):void
    {
        var proceedErrorCallback:Function = function():void
        {
            proceedError(info);
        };

        var retryRequestCallback:Function = function():void
        {
            retryRequest();
        };

        if (client.errorInterceptor.length == 2)
            client.errorInterceptor(info, responseCode)(attempts, proceedErrorCallback, retryRequestCallback);
        else
            client.errorInterceptor(info)(attempts, proceedErrorCallback, retryRequestCallback);
    }

    private function retryRequest():void
    {
        attempts++;

        client.retry();
    }

    private function proceedError(info:Object):void
    {
        if (client.errorCallback.length == 2)
            client.errorCallback(info, responseCode);
        else
           client.errorCallback(info);

        dispose();
    }
}
}
