/**
 * Created by mobitile on 11/3/14.
 */
package skein.locale.core.loader
{
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.utils.getDefinitionByName;

import skein.locale.core.SourceLoader;

public class SourceLoaderFileStream implements SourceLoader
{
    //--------------------------------------------------------------------------
    //
    //  Class const
    //
    //--------------------------------------------------------------------------

    private static var File:Class;
    private static var FileStream:Class;

    //--------------------------------------------------------------------------
    //
    //  Static initialization
    //
    //--------------------------------------------------------------------------

    {
        try
        {
            File = getDefinitionByName("flash.filesystem::File") as Class;
            FileStream = getDefinitionByName("flash.filesystem::FileStream") as Class;
        }
        catch (error:Error)
        {
            // ignore all errors
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    public static function isSupported():Boolean
    {
        return File && FileStream;
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function SourceLoaderFileStream(async:Boolean = false)
    {
        super();

        this.async = async;
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var async:Boolean;

    private var stream:Object;

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  rawData
    //-------------------------------------

    private var _data:Object;

    public function get data():Object
    {
        return _data;
    }

    //--------------------------------------------------------------------------
    //
    //  Callbacks
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  addCompleteCallback
    //-------------------------------------

    private var completeCallbacks:Array = [];

    public function addCompleteCallback(callback:Function):void
    {
        if (completeCallbacks.indexOf(callback) == -1)
        {
            completeCallbacks.push(callback);
        }
    }

    public function removeCompleteCallback(callback:Function):void
    {
        var index:int = completeCallbacks.indexOf(callback);

        if (index != -1)
        {
            completeCallbacks.splice(index, 1);
        }
    }

    //-------------------------------------
    //  addErrorCallback
    //-------------------------------------

    private var errorCallbacks:Array = [];

    public function addErrorCallback(callback:Function):void
    {
        if (errorCallbacks.indexOf(callback) == -1)
        {
            errorCallbacks.push(callback);
        }
    }

    public function removeErrorCallback(callback:Function):void
    {
        var index:int = errorCallbacks.indexOf(callback);

        if (index != -1)
        {
            errorCallbacks.splice(index, 1);
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function load(path:String):void
    {
        if (stream == null)
        {
            var file:Object;

            try
            {
                file = new File(path);
            }
            catch (error:Error)
            {
                // ignore errors
            }

            if (!file || !file.exists)
            {
                try
                {
                    file = File.applicationDirectory.resolvePath(path);
                }
                catch (error:Error)
                {
                    // ignore errors
                }
            }

            stream = new FileStream();

            if (async)
            {
                stream.addEventListener(Event.COMPLETE, completeHandler);
                stream.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);

                stream.openAsync(file, "read");
            }
            else
            {
                try
                {
                    stream.open(file, "read");

                    notifyComplete(stream.readUTFBytes(stream.bytesAvailable));
                }
                catch (error:Error)
                {
                    notifyError(error);
                }
            }
        }
    }

    public function close():void
    {
        if (stream != null)
        {
            stream.close();

            stream.removeEventListener(Event.COMPLETE, completeHandler);
            stream.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            stream = null;
        }
    }

    public function dispose():void
    {
        close();

        completeCallbacks.length = 0;
        errorCallbacks.length = 0;
    }

    private function notifyComplete(data:Object):void
    {
        _data = data;

        for (var i:uint = 0, n:uint = completeCallbacks.length; i < n; i++)
        {
            var callback:Function = completeCallbacks[i];

            if (callback != null)
            {
                if (callback.length == 0)
                {
                    callback();
                }
                else if (callback.length == 1)
                {
                    callback(_data);
                }
            }
        }
    }

    private function notifyError(error:Error):void
    {
        for (var i:uint = 0, n:uint = errorCallbacks.length; i < n; i++)
        {
            var callback:Function = errorCallbacks[i];

            if (callback != null)
            {
                if (callback.length == 0)
                {
                    callback();
                }
                else if (callback.length == 1)
                {
                    callback(error);
                }
            }
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //--------------------------------------------------------------------------

    private function completeHandler(event:Event):void
    {
        try
        {
            notifyComplete(stream.readUTFBytes(stream.bytesAvailable))
        }
        catch (error:Error)
        {
            notifyError(error);
        }

        close();
    }

    private function errorHandler(event:ErrorEvent):void
    {
        notifyError(new Error(event.text, event.errorID));

        close();
    }
}
}
