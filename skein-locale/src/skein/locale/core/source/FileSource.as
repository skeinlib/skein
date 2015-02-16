/**
 * Created by mobitile on 11/3/14.
 */
package skein.locale.core.source
{
import flash.events.Event;
import flash.events.EventDispatcher;

import skein.locale.core.RawData;

import skein.locale.core.Source;
import skein.locale.core.SourceLoader;
import skein.locale.core.loader.SourceLoaderFileStream;
import skein.locale.core.loader.SourceLoaderURLLoader;

public class FileSource extends EventDispatcher implements Source
{
    public function FileSource(locale:String, bundle:String, path:String=null)
    {
        super();

        this.locale = locale;
        this.bundle = bundle;
        this.path = path;
    }

    private var locale:String;
    private var bundle:String;

    private var path:String;

    public function isLoaded():Boolean
    {
        return _data != null;
    }

    private var _data:Object;

    public function getData():Object
    {
        return _data;
    }

    public function load():void
    {
        var loader:SourceLoader;

        if (SourceLoaderFileStream.isSupported())
        {
            loader = new SourceLoaderFileStream();
        }
        else
        {
            loader = new  SourceLoaderURLLoader();
        }

        loader.addCompleteCallback(function(data:Object):void
        {
            _data = new RawData(locale, bundle, data);

            loader.dispose();

            dispatchEvent(new Event(Event.COMPLETE));
        });

        loader.addErrorCallback(function():void
        {
            loader.dispose();
        });

        var url:String = path || "locale/" + locale + "/" + bundle + ".properties";

        loader.load(url);
    }
}
}
