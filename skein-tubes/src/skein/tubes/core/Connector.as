package skein.tubes.core
{
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.NetStatusEvent;
import flash.net.GroupSpecifier;
import flash.net.NetConnection;
import flash.net.NetGroup;

import skein.core.skein_internal;
import skein.logger.Log;
import skein.utils.delay.callLater;
import skein.utils.delay.delayToEvent;

[Event(name="netStatus", type="flash.events.NetStatusEvent")]

[Event(name="error", type="flash.events.ErrorEvent")]

[Event(name="connect", type="flash.events.Event")]

[Event(name="close", type="flash.events.Event")]

public class Connector extends EventDispatcher
{
    //----------------------------------------------------------------------
    //
    //	Class constants
    //
    //----------------------------------------------------------------------

    //----------------------------------------------------------------------
    //
    //	Constructor
    //
    //----------------------------------------------------------------------

    public function Connector(name: String) {
        super();
        _name = name;
    }

    //----------------------------------------------------------------------
    //
    //	Variables
    //
    //----------------------------------------------------------------------


    //----------------------------------------------------------------------
    //
    //	Properties
    //
    //----------------------------------------------------------------------

    private var _name: String;
    public function get name(): String {
        return _name;
    }

    private var _isConnecting: Boolean = false;
    public function get isConnecting(): Boolean {
        return _isConnecting;
    }

    // connected

    private var _isConnected: Boolean;
    public function get isConnected(): Boolean {
        return _isConnected;
    }

    // connection

    private var _connection: NetConnection;
    public function get connection(): NetConnection {
        return _connection;
    }

    // group

    private var _group: NetGroup;
    public function get group(): NetGroup {
        return _group;
    }

    private var _address: String;
    public function get address(): String {
        return _address || Config.shared.address;
    }
    skein_internal function setAddress(value: String): void {
        _address = value;
    }

    // specifier

    private var _specifier: GroupSpecifier;
    public function get specifier(): GroupSpecifier {
        return _specifier || new GroupSpecifier(name);
    }
    skein_internal function setSpecifier(value: GroupSpecifier): void {
        _specifier = value;
    }

    //----------------------------------------------------------------------
    //
    //	Methods
    //
    //----------------------------------------------------------------------

    //-----------------------------------
    //	MARK: Connect
    //-----------------------------------

    public function whenConnected(callback: Function): void {
        if (isConnected) {
            callback();
        } else {
            delayToEvent(this, Event.CONNECT, callback);
        }
    }

    public function connect(): void {

        if (_isConnected) {
            return;
        }

        if (_isConnecting) {
            return;
        }

        connectToConnection();

        _isConnecting = true;
    }

    protected function connectToConnection(): void {
        Log.d("skein-tubes", "Attempt to connect to NetConnection with address=\""+ address +"\"");

        if (_connection == null) {
            _connection = new NetConnection();
        }

        _connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
        _connection.connect(address);
    }

    protected function onConnectionConnected():void {
        Log.d("skein-tubes", "Established connection to NetConnection");
        this.connectToGroup();
    }

    protected function connectToGroup():void {
        Log.d("skein-tubes", "Attempt to connect to NetGroup with specifier=\""+ specifier +"\"");

        _group = new NetGroup(connection, specifier.groupspecWithAuthorizations());
        _group.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
    }

    protected function onGroupConnected():void {
        Log.d("skein-tubes", "Established connection to NetGroup");

        callLater(function (): void {
            _isConnecting = false;
            _isConnected = true;
            dispatchEvent(new Event(Event.CONNECT));
        });
    }

    //-----------------------------------
    //	MARK: Disconnect
    //-----------------------------------

    public function disconnect():void {
        Log.d("skein-tubes", "Attempt to disconnect from NetGroup");

        if (_group) {
            _group.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            _group.close();
        }

        Log.d("skein-tubes", "Attempt to disconnect from NetConnection");

        if (_connection) {
            _connection.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            _connection.close();
        }

        Log.d("skein-tubes", "Disconnected");

        _isConnecting = false;
        _isConnected = false;

        this.dispatchEvent(new Event(Event.CLOSE));
    }

    //-----------------------------------
    //	MARK: Release
    //-----------------------------------

    public function release(): void {
        ConnectorRegistry.releaseConnector(this);
    }

    skein_internal function dispose(): void {
        Log.d("skein-tubes", "Dispose Connector with name " + name);
        disconnect();
        _connection = null;
        _group = null;
    }

    //--------------------------------------------------------------------------
    //
    //	Wrappers
    //
    //--------------------------------------------------------------------------

    public function get myId(): String {
        return _connection ? _connection.nearID : null;
    }

    public function convertPeerIDToGroupAddress(peerID: String): String {
        return _group ? _group.convertPeerIDToGroupAddress(peerID) : null;
    }

    //--------------------------------------------------------------------------
    //
    //	Callbacks
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  MARK: Status callback
    //-------------------------------------

    protected var _netStatusCallbacks: Vector.<Function> = new <Function>[];
    public function addNetStatusCallback(handler: Function): Boolean {
        if (_netStatusCallbacks.indexOf(handler) != -1) {
            return false;
        }
        _netStatusCallbacks[_netStatusCallbacks.length] = handler;
        return true;
    }
    public function removeNetStatusCallback(handler: Function): Boolean {
        var index: int = _netStatusCallbacks.indexOf(handler);
        if (index == -1) {
            return false;
        }
        _netStatusCallbacks.removeAt(_netStatusCallbacks.indexOf(handler));
        return true;
    }
    private function notifyNetStatusCallbacks(event: NetStatusEvent): void {
        for each (var handler: Function in _netStatusCallbacks) {
            handler(event);
        }
    }

    //-------------------------------------
    //  MARK: Error callback
    //-------------------------------------

    protected var _errorCallbacks: Vector.<Function> = new <Function>[];
    public function addErrorCallback(handler: Function): Boolean {
        if (_errorCallbacks.indexOf(handler) != -1) {
            return false;
        }
        _errorCallbacks[_errorCallbacks.length] = handler;
        return true;
    }
    public function removeErrorCallback(handler: Function): Boolean {
        var index: int = _errorCallbacks.indexOf(handler);
        if (index == -1) {
            return false;
        }
        _errorCallbacks.removeAt(_errorCallbacks.indexOf(handler));
        return true;
    }
    private function notifyErrorCallbacks(code: String, detail: Object = null): void {
        for each (var handler: Function in _errorCallbacks) {
            if (handler.length == 2) {
                handler(code, detail);
            } else if (handler.length == 1) {
                handler(code);
            } else {
                handler();
            }
        }
    }

    //----------------------------------------------------------------------
    //
    //	Handlers
    //
    //----------------------------------------------------------------------

    private function netStatusHandler(event:NetStatusEvent):void {
        Log.d("skein-tubes", "Handle NetStatusEvent with info.code=\"" + event.info.code + "\"");

        switch (event.info.code) {

            // NetConnection

            case "NetConnection.Connect.Success" :
                this.onConnectionConnected();
                break;

            case "NetConnection.Connect.Closed":
                this.disconnect();
                break;

            case "NetConnection.Connect.Failed":
            case "NetConnection.Connect.Rejected":
            case "NetConnection.Connect.AppShutdown":
            case "NetConnection.Connect.InvalidApp":
                this.disconnect();
                this.dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, event.info.code));
                break;

            // NetGroup

            case "NetGroup.Connect.Success": // e.info.group
                this.onGroupConnected();
                break;

            case "NetGroup.Connect.Rejected": // e.info.group
            case "NetGroup.Connect.Failed": // e.info.group
                this.disconnect();
                this.dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, event.info.code));
                break;

            case "NetGroup.Neighbor.Connect" :
                break;

            case "NetGroup.Neighbor.Disconnect" :
                break;
        }

        notifyNetStatusCallbacks(event);

        if (this.hasEventListener(event.type)) {
            this.dispatchEvent(event.clone());
        }
    }

}
}