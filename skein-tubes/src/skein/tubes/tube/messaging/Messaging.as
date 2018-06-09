/**
 * Created by max.rozdobudko@gmail.com on 6/7/18.
 */
package skein.tubes.tube.messaging {
import flash.events.NetStatusEvent;

import skein.core.skein_internal;
import skein.tubes.core.Connector;
import skein.tubes.core.emitter.Emitter;
import skein.tubes.core.emitter.EmitterEvent;

use namespace skein_internal;

public class Messaging extends Emitter {

    //--------------------------------------------------------------------------
    //
    // Constructor
    //
    //--------------------------------------------------------------------------

    public function Messaging(connector: Connector) {
        super();

        _connector = connector;
        _connector.addNetStatusCallback(netStatusHandler);
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
    //  MARK: Send
    //-------------------------------------

    public function emit(event: String, to: String, message: Object, callback: Function = null): void {
        _connector.whenConnected(function(): void {
            var result: String = _connector.group.sendToNearest({
                event: event,
                payload: message,
                from: _connector.myId,
                to: to
            }, _connector.convertPeerIDToGroupAddress(to));
            if (callback != null) {
                callback(result);
            }
        });
    }

    public function send(to: String, message: Object, callback: Function = null): void {
        emit(EmitterEvent.MESSAGE, to, message, callback);
    }

    //-------------------------------------
    //  MARK: Receive
    //-------------------------------------

    public function onMessage(handler: Function): void {
        on(EmitterEvent.MESSAGE, handler);
    }

    //-------------------------------------
    //  MARK: Dispose
    //-------------------------------------

    public function dispose(): void {
        if (_connector) {
            _connector.removeNetStatusCallback(netStatusHandler);
            _connector = null;
        }

        off();
    }

    //--------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //--------------------------------------------------------------------------

    private function netStatusHandler(event:NetStatusEvent):void {
        switch (event.info.code) {
            case "NetGroup.SendTo.Notify":
                if (event.info.fromLocal) {
                    notifySubscribers(event.info.message, {});
                } else {
                    _connector.group.sendToNearest(event.info.message, _connector.convertPeerIDToGroupAddress(event.info.message.to));
                }
                break;
        }
    }
}
}
