/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/7/14
 * Time: 1:09 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client.impl.extras.download
{
import flash.errors.IOError;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.OutputProgressEvent;
import flash.events.ProgressEvent;
import flash.utils.ByteArray;
import flash.utils.getDefinitionByName;

import skein.rest.client.extras.download.DownloadWriter;

public class FileStreamAsyncDownloadWriter implements DownloadWriter
{
    //--------------------------------------------------------------------------
    //
    //  Class const
    //
    //--------------------------------------------------------------------------

    protected static const File:Class = getDefinitionByName("flash.filesystem::File") as Class;

    protected static const FileMode:Class = getDefinitionByName("flash.filesystem::FileMode") as Class;

    protected static const FileStream:Class = getDefinitionByName("flash.filesystem::FileStream") as Class;

    //--------------------------------------------------------------------------
    //
    //  Class function
    //
    //--------------------------------------------------------------------------

    public static function isSupported():Boolean
    {
        return File != null && FileStream != null;
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function FileStreamAsyncDownloadWriter()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var file:Object;

    private var stream:Object;

    private var isLastPortionReceived:Boolean = false;

    //--------------------------------------------------------------------------
    //
    //  Callbacks
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  errorCallback
    //------------------------------------

    protected var _errorCallback:Function;

    public function errorCallback(callback:Function):void
    {
        _errorCallback = callback;
    }

    //------------------------------------
    //  completeCallback
    //------------------------------------

    protected var _completeCallback:Function;

    public function completeCallback(callback:Function):void
    {
        _completeCallback = callback;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-----------------------------------
    //  Methods: public
    //-----------------------------------

    public function start(to:Object):void
    {
        if (stream == null)
        {
            stream = new FileStream();
            stream.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            stream.addEventListener(OutputProgressEvent.OUTPUT_PROGRESS, outputProgressHandler);

            try
            {
                file = to;

                stream.openAsync(file, FileMode.WRITE);
            }
            catch (error:Error)
            {
                _errorCallback(error);
            }
        }
    }

    public function close():void
    {
        if (stream != null)
        {
            stream.close();
            stream.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            stream.removeEventListener(OutputProgressEvent.OUTPUT_PROGRESS, outputProgressHandler);

            stream = null;

            file = null;
        }

        isLastPortionReceived = false;
    }

    public function write(bytes:ByteArray, last:Boolean = false):void
    {
        isLastPortionReceived ||= last;

        try
        {
            stream.writeBytes(bytes);
        }
        catch (error:Error)
        {
            _errorCallback(error);
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Handlers
    //
    //--------------------------------------------------------------------------

    private function errorHandler(event:IOErrorEvent):void
    {
        _errorCallback(new IOError(event.text, event.errorID));
    }

    private function outputProgressHandler(event:OutputProgressEvent):void
    {
        if (event.bytesPending == 0 && isLastPortionReceived)
        {
            _completeCallback(file);
        }
    }
}
}
