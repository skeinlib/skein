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

public class FileStreamDownloadWriter implements DownloadWriter
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

    public function FileStreamDownloadWriter()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var destination:Object;

    private var stream:Object;

    private var busy:Boolean = true;

    private var buffer:Vector.<ByteArray> = new <ByteArray>[];

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
                destination = to;

                stream.openAsync(destination, FileMode.WRITE);

                busy = false;
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

            destination = null;
        }

        busy = true;
        buffer = new <ByteArray>[];
        isLastPortionReceived = false;
    }

    public function write(bytes:ByteArray, last:Boolean = false):void
    {
        isLastPortionReceived ||= last;

        if (bytes.length > 0)
            buffer.push(bytes);

        flush();
    }

    protected function flush():void
    {
        if (!busy)
        {
            if (buffer.length > 0)
            {
                busy = true;

                try
                {
                    stream.writeBytes(buffer.pop());
                }
                catch (error:Error)
                {
                    _errorCallback(error);
                }
            }
            else if (isLastPortionReceived)
            {
                _completeCallback(destination);
            }
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
        busy = false;

        flush();
    }
}
}
