/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 12/26/13
 * Time: 2:14 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes.tube
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.NetStream;

import skein.core.skein_internal;
import skein.tubes.core.TubeRegistry;
import skein.tubes.core.emitter.Emitter;
import skein.tubes.tube.connection.Connection;
import skein.tubes.tube.media.Broadcast;
import skein.tubes.tube.media.Playback;
import skein.tubes.tube.messaging.Messaging;
import skein.tubes.tube.neighborhood.Neighborhood;
import skein.tubes.tube.posting.Posting;
import skein.tubes.core.ConnectorRegistry;
import skein.tubes.core.Connector;
import skein.tubes.tube.media.settings.MediaSettings;
import skein.tubes.tube.sharing.Giver;
import skein.utils.delay.callLater;
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

    public function Tube(name: String) {
        super();
        _name = name;

        callLater(connect);
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  name
    //------------------------------------

    private var _name:String;
    public function get name():String {
        return _name;
    }

    //------------------------------------
    //  connector
    //------------------------------------

    private var _connector: Connector;
    public function get connector(): Connector {
        if (_connector == null) {
            _connector = ConnectorRegistry.retainConnector(name);
        }

        return _connector;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Methods: Connect
    //-------------------------------------

    public function connect(): void {
        connector.connect();
    }

    //-------------------------------------
    //  Methods: Dispose
    //-------------------------------------

    public function dispose(): void {
        if (_connector) {
            _connector.release();
            _connector = null;
        }

        if (_connection) {
            _connection.dispose();
            _connection = null;
        }

        if (_messaging) {
            _messaging.dispose();
            _messaging = null;
        }

        if (_posting) {
            _posting.dispose();
            _posting = null;
        }

        if (_broadcast) {
            _broadcast.removeEventListener(Event.CLOSE, broadcast_closeHandler);
            _broadcast.dispose();
            _broadcast = null;
        }

        for each (var playback: Playback in _playbacks) {
            playback.removeEventListener(Event.CLOSE, playback_closeHandler);
            playback.dispose();
        }
        _playbacks = {};

        dispatchEvent(new Event(Event.CLOSE));
    }

    //--------------------------------------------------------------------------
    //
    //  Connection
    //
    //--------------------------------------------------------------------------

    private var _connection: Connection;
    [Bindable(event="change")]
    public function get connection(): Connection {
        if (_connection == null) {
            _connection = new Connection(connector);
        }
        return _connection;
    }

    //--------------------------------------------------------------------------
    //
    //  Posting
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Methods: posting
    //-------------------------------------

    protected var _posting: Posting;
    [Bindable(event="change")]
    public function get posting(): Posting {
        if (_posting == null) {
            _posting = new Posting(connector);
        }

        return _posting;
    }

    //--------------------------------------------------------------------------
    //
    //  Messaging
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Methods: messaging
    //-------------------------------------

    private var _messaging: Messaging;
    [Bindable(event="change")]
    public function get messaging(): Messaging {
        if (_messaging == null) {
            _messaging = new Messaging(connector);
        }

        return _messaging;
    }

    //--------------------------------------------------------------------------
    //
    //  Neighborhood
    //
    //--------------------------------------------------------------------------

    private var _neighborhood: Neighborhood;
    [Bindable(event="change")]
    public function get neighborhood(): Neighborhood {
        if (_neighborhood == null) {
            _neighborhood = new Neighborhood(connector);
        }
        return _neighborhood;
    }

    //--------------------------------------------------------------------------
    //
    //  Media
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  MARK: Media settings
    //-------------------------------------

    private var _settings:MediaSettings;
    public function get settings(): MediaSettings {
        return _settings;
    }
    skein_internal function setSettings(value: MediaSettings): void {
        _settings = value;
    }

    //-------------------------------------
    //  MARK: broadcast
    //-------------------------------------

    protected var _broadcast:Broadcast;
    public function broadcast(name:String):Broadcast {
        if (_broadcast == null) {
            _broadcast = new Broadcast(connector, name, _settings);
            _broadcast.addEventListener(Event.CLOSE, broadcast_closeHandler);
        }

        return _broadcast;
    }

    //-------------------------------------
    //  MARK: playback
    //-------------------------------------

    protected var _playbacks: Object = {};
    public function playback(name: String): Playback {
        if (_playbacks[name]) {
            return _playbacks[name];
        }

        var playback: Playback = _playbacks[name] = new Playback(connector, name);
        playback.addEventListener(Event.CLOSE, playback_closeHandler);

        return playback;
    }

    //--------------------------------------------------------------------------
    //
    //  Sharing
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Mark: share
    //-------------------------------------

    protected var _shares:Object = {};
    public function share(data: Object, index:Number): Giver {

        if (_shares[index]) {
            return _shares[index];
        }

        var share: Giver = _shares[index] = new Giver(data, index, NaN);

        if (connector.connected)
        {
            share.setGroup(connector.group);
        }
        else
        {
            delayToEvent(connector, Event.CONNECT, function(): void {
                share.setGroup(connector.group);
            });
        }

        return share;
    }

    //--------------------------------------------------------------------------
    //
    //  Callbacks
    //
    //--------------------------------------------------------------------------

    public function onConnect(handler: Function): void {
        var self: Tube = this;
        connection.addConnectCallback(function(): void {
            handler(self);
        });
    }

    public function onDisconnect(handler: Function): void {
        var self: Tube = this;
        connection.addDisconnectCallback(function(): void {
            handler(self);
        });
    }

    //--------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //--------------------------------------------------------------------------

    //---------------------------------------
    //  broadcast
    //---------------------------------------

    private function broadcast_closeHandler(event:Event):void {
        _broadcast.removeEventListener(Event.CLOSE, broadcast_closeHandler);
        _broadcast = null;
    }

    //---------------------------------------
    //  playback
    //---------------------------------------

    private function playback_closeHandler(event:Event):void {
        var playback:Playback = event.target as Playback;
        playback.removeEventListener(Event.CLOSE, playback_closeHandler);

        _playbacks[playback.name] = null;
        delete _playbacks[playback.name];
    }
}
}
