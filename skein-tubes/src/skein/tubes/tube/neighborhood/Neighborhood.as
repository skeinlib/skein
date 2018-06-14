/**
 * Created by max.rozdobudko@gmail.com on 6/8/18.
 */
package skein.tubes.tube.neighborhood {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.NetStatusEvent;

import skein.logger.Log;

import skein.tubes.tube.Tube;
import skein.utils.delay.callLater;
import skein.utils.delay.delayToEvent;

public class Neighborhood extends EventDispatcher {

    //--------------------------------------------------------------------------
    //
    // Constructor
    //
    //--------------------------------------------------------------------------

    public function Neighborhood(tube: Tube) {
        super();

        _tube = tube;
        
        _tube.connector.addNetStatusCallback(netStatusHandler);
    }

    //--------------------------------------------------------------------------
    //
    //  Dependencies
    //
    //--------------------------------------------------------------------------
    
    protected var _tube: Tube;

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    // neighbors

    private var _neighbors: Vector.<String> = new <String>[];
    [Bindable(event="change")]
    public function get neighbors(): Vector.<String> {
        return _neighbors;
    }

    // hasNeighbors

    public function get hasNeighbors(): Boolean {
        return _neighbors.length > 0;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  MARK: Dispose
    //-------------------------------------

    public function whenNotAlone(callback: Function): void {
        if (_neighbors.length > 0) {
            if (callback != null) {
                callback();
            }
        } else {
            Log.d("skein-tubes", "Neighborhood: wait for at least one peer is connected.");
            delayToEvent(this, Event.ADDED, function(): void {
                if (callback != null) {
                    callLater(callback);
                }
            });
        }
    }

    //-------------------------------------
    //  MARK: Dispose
    //-------------------------------------

    public function dispose(): void {
        if (_tube) {
            _tube.connector.removeNetStatusCallback(netStatusHandler);
            _tube = null;
        }

        off();
    }

    //--------------------------------------------------------------------------
    //
    //  Callbacks
    //
    //--------------------------------------------------------------------------

    // Callback: Neighbor Connect

    protected var _neighborConnectCallbacks: Vector.<Function> = new <Function>[];
    public function onConnect(handler: Function): Boolean {
        if (_neighborConnectCallbacks.indexOf(handler) != -1) {
            return false;
        }
        _neighborConnectCallbacks[_neighborConnectCallbacks.length] = handler;
        return true;
    }
    private function notifyNeighborConnectCallbacks(peerId: String): void {
        for each (var handler: Function in _neighborConnectCallbacks) {
            if (handler.length == 1) {
                handler(peerId);
            } else {
                handler();
            }
        }
    }

    // Callback: Neighbor Disconnect

    protected var _neighborDisconnectCallbacks: Vector.<Function> = new <Function>[];
    public function onDisconnect(handler: Function): Boolean {
        if (_neighborDisconnectCallbacks.indexOf(handler) != -1) {
            return false;
        }
        _neighborDisconnectCallbacks[_neighborDisconnectCallbacks.length] = handler;
        return true;
    }
    private function notifyNeighborDisconnectCallbacks(peerId: String): void {
        for each (var handler: Function in _neighborDisconnectCallbacks) {
            if (handler.length == 1) {
                handler(peerId);
            } else {
                handler();
            }
        }
    }

    // Callback: off

    public function off(handler: Function = null): void {
        if (handler == null) {
            _neighborConnectCallbacks.length = 0;
            _neighborDisconnectCallbacks.length = 0;
            return;
        }

        if (_neighborConnectCallbacks.indexOf(handler) != -1) {
            _neighborConnectCallbacks.removeAt(_neighborConnectCallbacks.indexOf(handler));
        }

        if (_neighborDisconnectCallbacks.indexOf(handler) != -1) {
            _neighborDisconnectCallbacks.removeAt(_neighborDisconnectCallbacks.indexOf(handler));
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //--------------------------------------------------------------------------

    protected function handleNeighborAdded(peerId: String): void {
        if (_neighbors.indexOf(peerId) != -1) {
            return;
        }
        _neighbors[_neighbors.length] = peerId;
        notifyNeighborConnectCallbacks(peerId);
        dispatchEvent(new Event(Event.CHANGE));
        dispatchEvent(new Event(Event.ADDED));
    }

    protected function handleNeighborRemoved(peerId: String): void {
        if (_neighbors.indexOf(peerId) == -1) {
            return;
        }
        _neighbors.removeAt(_neighbors.indexOf(peerId));
        notifyNeighborDisconnectCallbacks(peerId);
        dispatchEvent(new Event(Event.CHANGE));
        dispatchEvent(new Event(Event.REMOVED));
    }

    //--------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //--------------------------------------------------------------------------

    private function netStatusHandler(event: NetStatusEvent):void {
        switch (event.info.code) {

            case "NetGroup.Neighbor.Connect":
                handleNeighborAdded(event.info.peerID);
                break;

            case "NetGroup.Neighbor.Disconnect":
                handleNeighborRemoved(event.info.peerID);
                break;
        }
    }
}
}
