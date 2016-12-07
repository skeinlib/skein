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
import flash.utils.ByteArray;

import skein.core.skein_internal;
import skein.rest.client.impl.HandlerAbstract;

public class URLLoaderHandlerStandard extends HandlerAbstract implements URLLoaderHandler
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function URLLoaderHandlerStandard(client:DefaultRestClient)
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
        _loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, statusHandler);
        _loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
        _loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
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
        result(_loader.data);
    }

    internal function errorHandler(event:ErrorEvent):void
    {
        if (_loader.data is ByteArray && ByteArray(_loader.data).length == 0)
        {
            error(new Error(event.text, event.errorID));
        }
        else
        {
            error(_loader.data);
        }
    }

    internal function statusHandler(event:HTTPStatusEvent):void
    {
        status(event.status);
    }

    internal function progressHandler(event:ProgressEvent):void
    {
        progress(event.bytesLoaded, event.bytesTotal);
    }
}
}
