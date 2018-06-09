/**
 * Created by max.rozdobudko@gmail.com on 6/7/18.
 */
package skein.tubes.tube.connection {
import flash.events.ErrorEvent;
import flash.events.Event;

import skein.core.skein_internal;
import skein.tubes.core.Connector;

use namespace skein_internal;
public class Connection {

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Connection(connector: Connector) {
        super();
        _connector = connector;
        _connector.addEventListener(Event.CONNECT, connectHandler);
        _connector.addEventListener(Event.CLOSE, closeHandler);
        _connector.addEventListener(ErrorEvent.ERROR, errorHandler);
    }

    //--------------------------------------------------------------------------
    //
    //  Dependencies
    //
    //--------------------------------------------------------------------------

    private var _connector: Connector;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  MARK: Dispose
    //-------------------------------------

    public function dispose(): void {
        if (_connector) {
            _connector.addEventListener(Event.CONNECT, connectHandler);
            _connector.addEventListener(Event.CLOSE, closeHandler);
            _connector.addEventListener(ErrorEvent.ERROR, errorHandler);
            _connector = null;
        }

        removeErrorCallbacks();
        removeCloseCallbacks();
        removeConnectCallbacks();
        removeDisconnectCallbacks();
    }

    //--------------------------------------------------------------------------
    //
    //  Callbacks
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    // Callback: Error
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
    public function removeErrorCallbacks(): void {
        _errorCallbacks.length = 0;
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

    //-------------------------------------
    // Callback: Connect
    //-------------------------------------

    protected var _connectCallbacks: Vector.<Function> = new <Function>[];
    public function addConnectCallback(handler: Function): Boolean {
        if (_connectCallbacks.indexOf(handler) != -1) {
            return false;
        }
        _connectCallbacks[_connectCallbacks.length] = handler;
        return true;
    }
    public function removeConnectCallback(handler: Function): Boolean {
        var index: int = _connectCallbacks.indexOf(handler);
        if (index == -1) {
            return false;
        }
        _connectCallbacks.removeAt(_connectCallbacks.indexOf(handler));
        return true;
    }
    public function removeConnectCallbacks(): void {
        _connectCallbacks.length = 0;
    }
    private function notifyConnectCallbacks(): void {
        for each (var handler: Function in _connectCallbacks) {
            handler();
        }
    }

    //-------------------------------------
    // Callback: Closes callbacks
    //-------------------------------------

    protected var _closeCallbacks: Vector.<Function> = new <Function>[];
    public function addCloseCallback(handler: Function): Boolean {
        if (_closeCallbacks.indexOf(handler) != -1) {
            return false;
        }
        _closeCallbacks[_closeCallbacks.length] = handler;
        return true;
    }
    public function removeCloseCallback(handler: Function): Boolean {
        var index: int = _closeCallbacks.indexOf(handler);
        if (index == -1) {
            return false;
        }
        _closeCallbacks.removeAt(_closeCallbacks.indexOf(handler));
        return true;
    }
    public function removeCloseCallbacks(): void {
        _closeCallbacks.length = 0;
    }
    private function notifyCloseCallbacks(): void {
        for each (var handler: Function in _closeCallbacks) {
            handler();
        }
    }

    //-------------------------------------
    // Callback: Disconnect
    //-------------------------------------

    protected var _disconnectCallbacks: Vector.<Function> = new <Function>[];
    public function addDisconnectCallback(handler: Function): Boolean {
        if (_disconnectCallbacks.indexOf(handler) != -1) {
            return false;
        }
        _disconnectCallbacks[_disconnectCallbacks.length] = handler;
        return true;
    }
    public function removeDisconnectCallback(handler: Function): Boolean {
        var index: int = _disconnectCallbacks.indexOf(handler);
        if (index == -1) {
            return false;
        }
        _disconnectCallbacks.removeAt(_disconnectCallbacks.indexOf(handler));
        return true;
    }
    public function removeDisconnectCallbacks(): void {
        _disconnectCallbacks.length = 0;
    }
    private function notifyDisconnectCallbacks(): void {
        for each (var handler: Function in _disconnectCallbacks) {
            handler();
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //--------------------------------------------------------------------------

    private function connectHandler(event: Event): void {
        notifyConnectCallbacks();
    }

    private function closeHandler(event: Event): void {
        notifyDisconnectCallbacks();
    }

    private function errorHandler(event: ErrorEvent): void {
        notifyErrorCallbacks(event.text);
    }
}
}
