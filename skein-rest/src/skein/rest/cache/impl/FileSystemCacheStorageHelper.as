/**
 * Created by Max Rozdobudko on 10/2/15.
 */
package skein.rest.cache.impl
{
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.OutputProgressEvent;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.utils.ByteArray;

public class FileSystemCacheStorageHelper
{
    public static function save(file:File, data:Object, callback:Function = null):void
    {
        var outputProgressHandler:Function = function(event:OutputProgressEvent):void
        {
            if (event.bytesPending == 0)
            {
                stream.removeEventListener(Event.COMPLETE, outputProgressHandler);
                stream.removeEventListener(ErrorEvent.ERROR, errorHandler);

                stream.close();

                if (callback != null)
                    callback(true);
            }
        };

        var errorHandler:Function = function(event:ErrorEvent):void
        {
            stream.removeEventListener(Event.COMPLETE, outputProgressHandler);
            stream.removeEventListener(ErrorEvent.ERROR, errorHandler);

            stream.close();

            if (callback != null)
                callback(new Error(event.text, event.errorID));
        };

        var stream:FileStream = new FileStream();
        stream.addEventListener(OutputProgressEvent.OUTPUT_PROGRESS, outputProgressHandler);
        stream.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);

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

    public static function read(file:File, callback:Function):void
    {
        var completeHandler:Function = function(event:Event):void
        {
            stream.removeEventListener(Event.COMPLETE, completeHandler);
            stream.removeEventListener(ErrorEvent.ERROR, errorHandler);

            if (stream.bytesAvailable > 0)
            {
                try
                {
                    if (callback != null)
                        callback(stream.readObject());

                }
                catch (error:Error)
                {
                    try
                    {
                        file.deleteFile();
                    }
                    catch (error:Error) {}

                    if (callback != null)
                        callback(new Error("Not Found"));
                }
            }
            else
            {
                if (callback != null)
                    callback(new Error("Not Found"));
            }
        };

        var errorHandler:Function = function(event:ErrorEvent):void
        {
            stream.removeEventListener(Event.COMPLETE, completeHandler);
            stream.removeEventListener(ErrorEvent.ERROR, errorHandler);

            stream.close();

            if (callback != null)
                callback(new Error(event.text, event.errorID));
        };

        var stream:FileStream = new FileStream();
        stream.addEventListener(Event.COMPLETE, completeHandler);
        stream.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);

        if (file != null && file.exists)
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
