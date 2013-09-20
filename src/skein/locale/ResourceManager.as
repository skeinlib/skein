/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/5/13
 * Time: 12:01 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.locale
{
import flash.events.EventDispatcher;

import skein.locale.core.*;

import flash.events.Event;

public class ResourceManager extends EventDispatcher
{
    private static var _instance:ResourceManager;

    public static function get instance():ResourceManager
    {
        if (_instance == null)
            _instance = new ResourceManager();

        return _instance;
    }

    public function ResourceManager()
    {
        super();
    }

    private var bundleMap:Object = {};

    [Bindable(event="change")]
    public function getString(bundle:String, key:String, params:Array=null):String
    {
        var b:Bundle = findBundle(bundle, key);

        return b ? b.content[key] : null;
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var parsers:ParserChain = new ParserChain();

    private var locales:Array;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function setLocale(locale:String):void
    {
        setLocales([locale]);
    }

    [Bindable(event="change")]
    public function getLocales():Array
    {
        return locales;
    }

    public function setLocales(chain:Array):void
    {
        locales = chain;

        dispatchEvent(new Event(Event.CHANGE));
    }

    public function addSource(source:Source):void
    {
        if (source.isLoaded())
        {
            parseSource(source);
        }
        else
        {
            source.addEventListener(Event.COMPLETE, source_completeHandler);

            source.load();
        }
    }

    private function parseSource(source:Source):void
    {
        var bundles:Vector.<Bundle> = parsers.parse(source.getData());

        addBundles(bundles);
    }

    private function addBundles(bundles:Vector.<Bundle>):void
    {
        if (bundles && bundles.length > 0)
        {
            for (var i:int, n:int = bundles.length; i < n; i++)
            {
                var b:Bundle = bundles[i];

                bundleMap[b.locale] ||= {};

                bundleMap[b.locale][b.name] = b;
            }

            dispatchEvent(new Event(Event.CHANGE));
        }
    }

    private function findBundle(name:String, resource:String):Bundle
    {
        for each (var locale:String in locales)
        {
            var bundles:Object = bundleMap[locale];

            if (bundles == null)
                continue;

            var bundle:Bundle = bundles[name];

            if (bundle == null)
                continue;

            if (bundle.content && Object(bundle.content).hasOwnProperty(resource))
                return bundle;
        }

        return null;
    }

    //--------------------------------------------------------------------------
    //
    //  Handlers
    //
    //--------------------------------------------------------------------------

    private function source_completeHandler(event:Event):void
    {
        var source:Source = event.target as Source;

        source.removeEventListener(Event.COMPLETE, source_completeHandler);

        parseSource(source);
    }
}
}
