/**
 * Created by Max Rozdobudko on 10/2/15.
 */
package skein.rest.cache.impl
{
import flash.debugger.enterDebugger;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.OutputProgressEvent;
import flash.utils.ByteArray;
import flash.utils.getDefinitionByName;

public class FileSystemCacheStorageHelper
{
    //--------------------------------------------------------------------------
    //
    //  AIR classes references
    //
    //--------------------------------------------------------------------------

    protected static const File:Class = getDefinitionByName("flash.filesystem::File") as Class;

    protected static const FileMode:Class = getDefinitionByName("flash.filesystem::FileMode") as Class;

    protected static const FileStream:Class = getDefinitionByName("flash.filesystem::FileStream") as Class;

    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    public static function save(file:Object, data:Object, callback:Function = null):void
    {
        var outputProgressHandler:Function = function(event:OutputProgressEvent):void
        {
            if (event.bytesPending == 0)
            {
                stream.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
                stream.removeEventListener(OutputProgressEvent.OUTPUT_PROGRESS, outputProgressHandler);

                stream.close();

                if (data is ByteArray && ByteArray(data).length != event.bytesTotal)
                {
                    enterDebugger();
                }

                if (callback != null)
                    callback(event.bytesTotal);
            }
        };

        var errorHandler:Function = function(event:IOErrorEvent):void
        {
            stream.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            stream.removeEventListener(OutputProgressEvent.OUTPUT_PROGRESS, outputProgressHandler);

            stream.close();

            if (callback != null)
                callback(new Error(event.text, event.errorID));
        };

        var stream:Object = new FileStream();
        stream.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
        stream.addEventListener(OutputProgressEvent.OUTPUT_PROGRESS, outputProgressHandler);

        try
        {
            stream.openAsync(file, FileMode.WRITE);

            if (data is ByteArray)
            {
                stream.writeBytes(data as ByteArray);
            }
            else
            {
                stream.writeObject(data);
            }
        }
        catch (error:Error)
        {
            if (callback != null)
                callback(error);
        }
    }

    public static function readObject(file:Object, callback:Function):void
    {
        open(file, function(value:*=undefined):void
        {
            if (value is FileStream)
            {
                var stream:Object = value as FileStream;

                var object:Object = stream.readObject();

                stream.close();

                callback(object);
            }
            else if (value is Error)
            {
                callback(value as Error);
            }
            else
            {
                callback();
            }
        });
    }

    public static function readBytes(file:Object, callback:Function):void
    {
        open(file, function(value:*=undefined):void
        {
            if (value is FileStream)
            {
                var stream:Object = value as FileStream;

                var bytes:ByteArray = new ByteArray();
                stream.readBytes(bytes);

                stream.close();

                callback(bytes);
            }
            else if (value is Error)
            {
                callback(value as Error);
            }
            else
            {
                callback();
            }
        });
    }

    public static function open(file:Object, callback:Function):void
    {
        var completeHandler:Function = function(event:Event):void
        {
            stream.removeEventListener(Event.CLOSE, closeHandler);
            stream.removeEventListener(Event.COMPLETE, completeHandler);
            stream.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);

            if (stream.bytesAvailable > 0)
            {
                try
                {
                    if (callback != null)
                        callback(stream);

                }
                catch (error:Error)
                {
                    try
                    {
                        file.deleteFile();
                    }
                    catch (error:Error) {}
                }
            }
            else
            {
                if (callback != null)
                    callback(new Error("Not Found"));
            }
        };

        var errorHandler:Function = function(event:IOErrorEvent):void
        {
            stream.removeEventListener(Event.CLOSE, closeHandler);
            stream.removeEventListener(Event.COMPLETE, completeHandler);
            stream.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);

            stream.close();

            if (callback != null)
                callback(new Error(event.text, event.errorID));
        };

        var closeHandler:Function = function(event:Event):void
        {
            stream.removeEventListener(Event.CLOSE, closeHandler);
            stream.removeEventListener(Event.COMPLETE, completeHandler);
            stream.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);

            // do not call callback due to stream has been closed by result callback
        };

        var stream:Object = new FileStream();
        stream.addEventListener(Event.CLOSE, closeHandler);
        stream.addEventListener(Event.COMPLETE, completeHandler);
        stream.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);

        if (file != null)
        {
            try
            {
                stream.openAsync(file, FileMode.READ);
            }
            catch (error:Error)
            {
                if (callback != null)
                    callback(error);
            }
        }
        else
        {
            if (callback != null)
                callback(new Error("Not Found"));
        }
    }
}
}
