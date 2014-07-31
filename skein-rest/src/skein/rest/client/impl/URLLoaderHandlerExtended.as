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

import skein.rest.client.impl.HandlerAbstract;

import skein.rest.core.HeaderHandler;

public class URLLoaderHandlerExtended extends HandlerAbstract implements URLLoaderHandler
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function URLLoaderHandlerExtended(client:DefaultRestClient)
    {
        super(client);
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var _loader:URLLoader;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function handle(loader:URLLoader):void
    {
        _loader = loader;

        _loader.addEventListener(Event.COMPLETE, resultHandler);
        _loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, responseStatusHandler)
        _loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, statusHandler);
        _loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
        _loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
        _loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden Methods
    //
    //--------------------------------------------------------------------------

    override protected function dispose():void
    {
        super.dispose();

        _loader.removeEventListener(Event.COMPLETE, resultHandler);
        _loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, statusHandler);
        _loader.removeEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, responseStatusHandler);
        _loader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
        _loader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
        _loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);

        _loader = null;
    }

    //--------------------------------------------------------------------------
    //
    //  Handlers
    //
    //--------------------------------------------------------------------------

    private function resultHandler(event:Event):void
    {
        if (responseCode >= 200 && responseCode < 300) // result
        {
            result(_loader.data);
        }
        else // error
        {
            error(_loader.data)
        }
    }

    private function errorHandler(event:ErrorEvent):void
    {
        error(_loader.data);
    }

    private function statusHandler(event:HTTPStatusEvent):void
    {
        status(event.status);
    }

    private function responseStatusHandler(event:HTTPStatusEvent):void
    {
        headers(event.responseHeaders);

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

    private  function progressHandler(event:ProgressEvent):void
    {
        progress(event.bytesLoaded, event.bytesTotal);
    }
}
}
