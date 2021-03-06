/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/26/13
 * Time: 2:45 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.locale.core.source
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLLoader;
import flash.net.URLRequest;

import skein.locale.core.RawData;

import skein.locale.core.Source;
import skein.locale.core.loader.SourceLoaderURLLoader;

[Event(name="complete", type="flash.events.Event")]

public class ExternalSource extends EventDispatcher implements Source
{
    public function ExternalSource(locale:String, bundle:String, path:String=null)
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
        var loader:SourceLoaderURLLoader = new SourceLoaderURLLoader();

        loader.addCompleteCallback(function(data:Object):void
        {
            _data = new RawData(locale, bundle, data);

            dispatchEvent(new Event(Event.COMPLETE));

            loader.dispose();
        });

        loader.addErrorCallback(function(error:Error):void
        {
            loader.dispose();
        });

        var url:String = path || "/locale/" + locale + "/" + bundle + ".properties";

        loader.load(url);
    }

}
}
