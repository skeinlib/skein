package skein.tubes.core
{
import flash.events.DataEvent;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.NetStatusEvent;
import flash.net.GroupSpecifier;
import flash.net.NetConnection;
import flash.net.NetGroup;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

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

    public function Connector()
    {
        super();
    }

    //----------------------------------------------------------------------
    //
    //	Variables
    //
    //----------------------------------------------------------------------

    private var address:String;

    private var context:String;

    //----------------------------------------------------------------------
    //
    //	Properties
    //
    //----------------------------------------------------------------------

    private var _connected:Boolean;

    public function get connected():Boolean
    {
        return _connected;
    }

    private var _connection:NetConnection;

    public function get connection():NetConnection
    {
        return _connection;
    }

    private var _group:NetGroup;

    public function get group():NetGroup
    {
        return _group;
    }

    private var _specifier:GroupSpecifier;

    public function get specifier():GroupSpecifier
    {
        return _specifier;
    }

    //----------------------------------------------------------------------
    //
    //	Methods
    //
    //----------------------------------------------------------------------

    //-----------------------------------
    //	Methods: Public API
    //-----------------------------------

    public function connect(address:String=null, context:String="mobitile-capabilities"):void
    {
        this.address = address || "rtmfp://p2p.rtmfp.net/4eac03fdddf60bb5e7df9cb3-c21addd5ccab";
        this.context = context;

        this.doConnect();
    }

    public function disconnect():void
    {
        trace("Connector.disconnect()");

        trace("Attempt to disconnect from NetGroup");

        if (_group)
        {
            _group.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            _group.close();
        }

        trace("Attempt to disconnect from NetConnection");

        if (_connection)
        {
            _connection.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            _connection.close();
        }

        trace("Disconnected");

        _connected = false;

        this.dispatchEvent(new Event(Event.CLOSE));
    }

    //-----------------------------------
    //	Methods: connection
    //-----------------------------------

    private function doConnect():void
    {
        if (_connection && _connection.connected)
        {
            this.dispatchEvent(new Event(Event.CONNECT));

            return;
        }

        if (!_connection)
            _connection = new NetConnection();

        _connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
        _connection.connect(this.address);
    }

    private function onConnected():void
    {
        if (!_specifier)
            _specifier = new GroupSpecifier(this.context);

        _specifier.multicastEnabled = true;
        _specifier.postingEnabled = true;
        _specifier.routingEnabled = true;
        _specifier.serverChannelEnabled = true;
        _specifier.objectReplicationEnabled = true;

        this.doGroupConnect();
    }

    //-----------------------------------
    //	Methods: group
    //-----------------------------------

    private function doGroupConnect():void
    {
        _group = new NetGroup(_connection, _specifier.groupspecWithAuthorizations());
        _group.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
    }

    private function onGroupConnected():void
    {
        trace("Connected to NetGroup");

        const t:uint = setTimeout(
            function():void
            {
                clearTimeout(t);

                _connected = true;

                dispatchEvent(new Event(Event.CONNECT));
            },
        1);
    }

    //----------------------------------------------------------------------
    //
    //	Handlers
    //
    //----------------------------------------------------------------------

    private function netStatusHandler(event:NetStatusEvent):void
    {
        trace(">>>>>>>>>>>>", event.info.code);

        if (event.info.level)
        {
            trace(event.info.code);
        }

        switch (event.info.code)
        {
            // NetConnection

            case "NetConnection.Connect.Success" :

                this.onConnected()

                break;

            case "NetConnection.Connect.Closed":

                this.disconnect();

                break;

            case "NetConnection.Connect.Failed":
            case "NetConnection.Connect.Rejected":
            case "NetConnection.Connect.AppShutdown":
            case "NetConnection.Connect.InvalidApp":

                this.disconnect();
                this.dispatchEvent(new ErrorEvent(ErrorEvent.ERROR));

                break;

            // NetGroup

            case "NetGroup.Connect.Success": // e.info.group

                this.onGroupConnected();

                break;

            case "NetGroup.Connect.Rejected": // e.info.group
            case "NetGroup.Connect.Failed": // e.info.group

                this.disconnect();
                this.dispatchEvent(new ErrorEvent(ErrorEvent.ERROR));

                break;

            case "NetGroup.Neighbor.Connect" :


                break;

            case "NetGroup.Neighbor.Disconnect" :


                break;
        }

        if (this.hasEventListener(event.type))
        {
            this.dispatchEvent(event.clone());
        }
    }

}
}