/**
 * Created by max.rozdobudko@gmail.com on 10/13/16.
 */
package skein.rest.core
{
import flash.utils.Dictionary;

import skein.core.skein_internal;

import skein.rest.client.RestClient;

public class ProgressTracker
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    private static const tracks:Dictionary = new Dictionary(true);

    //--------------------------------------------------------------------------
    //
    //  Class properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  loaded
    //-------------------------------------

    private static var _loaded:Number;
    public static function get loaded():Number
    {
        return _loaded;
    }

    //-------------------------------------
    //  total
    //-------------------------------------

    private static var _total:Number;
    public static function get total():Number
    {
        return _total;
    }

    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    skein_internal static function progress(client:RestClient, loaded:Number, total:Number):void
    {
        tracks[client] = new Tracking(loaded, total);

        updateProperties();
    }

    skein_internal static function complete(client:RestClient):void
    {
        delete tracks[client];

        updateProperties();
    }

    private static function updateProperties():void
    {
        _loaded = 0;
        _total = 0;

        for each (var tracking:Tracking in tracks)
        {
            _loaded += tracking.loaded;
            _total += tracking.total;
        }
    }
}
}

class Tracking
{
    public function Tracking(loaded:Number, total:Number)
    {
        this.loaded = loaded;
        this.total = total || NaN;
    }

    public var loaded:Number = NaN;
    public var total:Number = NaN;
}