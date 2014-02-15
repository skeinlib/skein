/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 12/26/13
 * Time: 2:14 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.NetStream;

import skein.core.skein_internal;
import skein.tubes.controls.Broadcast;
import skein.tubes.controls.Playback;
import skein.tubes.core.ConnectorRegistry;
import skein.tubes.core.Connector;
import skein.tubes.data.MediaSettings;
import skein.tubes.controls.Share;
import skein.utils.delay.delayToEvent;

use namespace skein_internal;

[Event(name="close", type="flash.events.Event")]

public class Tube extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Tube(name:String)
    {
        super();

        _name = name;
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    protected var _broadcast:Broadcast;

    protected var _playbacks:Object = {};

    protected var _shares:Object = {};

    private var _settings:MediaSettings;

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  name
    //------------------------------------

    private var _name:String;

    public function get name():String
    {
        return _name;
    }

    //------------------------------------
    //  connector
    //------------------------------------

    private var _connector:Connector;

    public function get connector():Connector
    {
        if (_connector == null)
        {
            _connector = ConnectorRegistry.getConnector(name);
        }

        return _connector;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    skein_internal function settings(value:MediaSettings):void
    {
        _settings = value;
    }

    skein_internal function close():void
    {
        ConnectorRegistry.freeConnector(connector);
    }

    private function closeIfNeed():void
    {
        if (_broadcast != null)
            return;

        for (var p:String in _playbacks)
            return;

        close();
    }

    //-------------------------------------
    //  Methods: broadcast
    //-------------------------------------

    public function broadcast(name:String):Broadcast
    {
        _broadcast = new Broadcast(name, _settings);
        _broadcast.addEventListener(Event.CLOSE, broadcast_closeHandler);

        if (connector.connected)
        {
            _broadcast.setStream(new NetStream(connector.connection, connector.specifier.groupspecWithAuthorizations()));
        }
        else
        {
            delayToEvent(connector, Event.CONNECT,
                function(name:String):void
                {
                    _broadcast.setStream(new NetStream(connector.connection, connector.specifier.groupspecWithAuthorizations()));
                },
                name);
        }

        return _broadcast;
    }

    //-------------------------------------
    //  Methods: playback
    //-------------------------------------

    public function playback(name:String):Playback
    {
        if (_playbacks[name])
            return _playbacks[name];

        var playback:Playback = _playbacks[name] = new Playback(name);
        playback.addEventListener(Event.CLOSE, playback_closeHandler);

        if (connector.connected)
        {
            playback.setStream(new NetStream(connector.connection, connector.specifier.groupspecWithAuthorizations()));
        }
        else
        {
            delayToEvent(connector, Event.CONNECT,
                function(name:String):void
                {
                    playback.setStream(new NetStream(connector.connection, connector.specifier.groupspecWithAuthorizations()));
                },
                name);
        }

        return playback;
    }

    //-------------------------------------
    //  Methods: share
    //-------------------------------------

    public function share(data:Object, index:Number):Share
    {
        if (_shares[index])
            return _shares[index];

        var share:Share = _shares[index] = new Share(data, index, NaN);

        if (connector.connected)
        {
            share.setGroup(connector.group);
        }
        else
        {
            delayToEvent(connector, Event.CONNECT,
                function(name:String):void
                {
                    share.setGroup(connector.group);
                },
                data, index);
        }

        return share;
    }


    //--------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //--------------------------------------------------------------------------

    //---------------------------------------
    //  broadcast
    //---------------------------------------

    private function broadcast_closeHandler(event:Event):void
    {
        var broadcast:Broadcast = event.target as Broadcast;
        broadcast.removeEventListener(Event.CLOSE, broadcast_closeHandler);

        closeIfNeed();
    }

    //---------------------------------------
    //  playback
    //---------------------------------------

    private function playback_closeHandler(event:Event):void
    {
        var playback:Playback = event.target as Playback;
        playback.removeEventListener(Event.CLOSE, playback_closeHandler);

        _playbacks[playback.name] = null;
        delete _playbacks[playback.name];

        closeIfNeed();
    }
}
}
