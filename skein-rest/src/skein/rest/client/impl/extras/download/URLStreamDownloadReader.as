/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/7/14
 * Time: 1:07 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client.impl.extras.download
{
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLRequest;
import flash.net.URLStream;
import flash.utils.ByteArray;

import skein.rest.client.extras.download.DownloadReader;

public class URLStreamDownloadReader implements DownloadReader
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function URLStreamDownloadReader()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var stream:URLStream;

    //--------------------------------------------------------------------------
    //
    //  Callbacks
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  progressCallback
    //------------------------------------

    protected var _progressCallback:Function;

    public function progressCallback(callback:Function):void
    {
        _progressCallback = callback;
    }

    //------------------------------------
    //  completeCallback
    //------------------------------------

    protected var _completeCallback:Function;

    public function completeCallback(callback:Function):void
    {
        _completeCallback = callback;
    }

    //------------------------------------
    //  errorCallback
    //------------------------------------

    protected var _errorCallback:Function;

    public function errorCallback(callback:Function):void
    {
        _errorCallback = callback;
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function start(from:Object):void
    {
        if (stream == null)
        {
            stream = new URLStream();
            stream.addEventListener(Event.OPEN, openHandler);
            stream.addEventListener(Event.COMPLETE, completeHandler);
            stream.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            stream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
            stream.addEventListener(ProgressEvent.PROGRESS, progressHandler);

            var request:URLRequest = new URLRequest(from as String);

            stream.load(request);
        }
    }

    public function close():void
    {
        if (stream != null)
        {
            stream.close();
            stream.removeEventListener(Event.OPEN, openHandler);
            stream.removeEventListener(Event.COMPLETE, completeHandler);
            stream.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            stream.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
            stream.removeEventListener(ProgressEvent.PROGRESS, progressHandler);

            stream = null;
        }
    }

    public function getBytes():ByteArray
    {
        var bytes:ByteArray = new ByteArray();

        if (stream != null)
            stream.readBytes(bytes);

        return bytes;
    }

    //--------------------------------------------------------------------------
    //
    //  Handlers
    //
    //--------------------------------------------------------------------------

    private function openHandler(event:Event):void
    {

    }

    private function errorHandler(event:ErrorEvent):void
    {
        _errorCallback(new Error(event.text, event.errorID));
    }

    private function completeHandler(event:Event):void
    {
        _completeCallback();
    }

    private function progressHandler(event:ProgressEvent):void
    {
        _progressCallback();
    }

}
}
