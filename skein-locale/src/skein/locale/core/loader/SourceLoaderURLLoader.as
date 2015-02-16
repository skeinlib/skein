/**
 * Created by mobitile on 11/3/14.
 */
package skein.locale.core.loader
{
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

import skein.locale.core.*;

public class SourceLoaderURLLoader implements SourceLoader
{
    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    public static function isSupported():Boolean
    {
        return true;
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function SourceLoaderURLLoader()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var loader:URLLoader;

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

    public function load(url:String):void
    {
        if (loader == null)
        {
            loader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, completeHandler);
            loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);

            loader.load(new URLRequest(url));
        }
    }

    public function close():void
    {
        if (loader != null)
        {
            loader.close();

            loader.removeEventListener(Event.COMPLETE, completeHandler);
            loader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
            loader = null;
        }
    }

    public function dispose():void
    {
        close();

        completeCallbacks.length = 0;
        errorCallbacks.length = 0;
    }

    //--------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //--------------------------------------------------------------------------

    private function completeHandler(event:Event):void
    {
        _data = URLLoader(event.target).data;

        for (var i:uint = 0, n:uint = completeCallbacks.length; i < n; i++)
        {
            var callback:Function = completeCallbacks[i];

            if (callback != null)
            {
                if (callback.length == 0)
                {
                    callback.apply(null);
                }
                else if (callback.length == 1)
                {
                    callback(_data);
                }
            }
        }

        close();
    }

    private function errorHandler(event:ErrorEvent):void
    {
        for (var i:uint = 0, n:uint = errorCallbacks.length; i < n; i++)
        {
            var callback:Function = errorCallbacks[i];

            if (callback != null)
            {
                if (callback.length == 0)
                {
                    callback.apply(null);
                }
                else if (callback.length == 1)
                {
                    callback(new Error(event.text, event.errorID));
                }
            }
        }

        close();
    }
}
}
