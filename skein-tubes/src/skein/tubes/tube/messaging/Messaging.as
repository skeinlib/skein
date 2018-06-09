/**
 * Created by max.rozdobudko@gmail.com on 6/7/18.
 */
package skein.tubes.tube.messaging {
import flash.events.NetStatusEvent;

import skein.core.skein_internal;
import skein.tubes.core.emitter.Emitter;
import skein.tubes.core.emitter.EmitterEvent;
import skein.tubes.tube.Tube;

use namespace skein_internal;

public class Messaging extends Emitter {

    //--------------------------------------------------------------------------
    //
    // Constructor
    //
    //--------------------------------------------------------------------------

    public function Messaging(tube: Tube) {
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
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  MARK: Send
    //-------------------------------------

    public function emit(event: String, message: Object, callback: Function = null): void {
        _tube.neighborhood.whenNotAlone(function(): void {
            var result: String = _tube.connector.group.sendToAllNeighbors({
                event: event,
                payload: message,
                from: _tube.connector.myId
            });
            if (callback != null) {
                callback(result);
            }
        });
    }

    public function send(to: String, message: Object, callback: Function = null): void {
        _tube.neighborhood.whenNotAlone(function(): void {
            var result: String = _tube.connector.group.sendToNearest({
                event: EmitterEvent.MESSAGE,
                payload: message,
                from: _tube.connector.myId,
                to: to
            }, _tube.connector.convertPeerIDToGroupAddress(to));
            if (callback != null) {
                callback(result);
            }
        });
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
        if (_tube) {
            _tube.connector.removeNetStatusCallback(netStatusHandler);
            _tube = null;
        }

        off();
    }

    //--------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //--------------------------------------------------------------------------

    protected function netStatusHandler(event: NetStatusEvent):void {
        switch (event.info.code) {
            case "NetGroup.SendTo.Notify":
                if (event.info.message.to) {
                    handleDirectMessage(event);
                } else {
                    handleCommonMessage(event);
                }
                break;
        }
    }

    protected function handleDirectMessage(event: NetStatusEvent): void {
        if (event.info.fromLocal) {
            notifySubscribers(event.info.message, {tube: _tube});
        } else {
            _tube.connector.group.sendToNearest(event.info.message, _tube.connector.convertPeerIDToGroupAddress(event.info.message.to));
        }
    }

    protected function handleCommonMessage(event: NetStatusEvent): void {
        notifySubscribers(event.info.message, {tube: _tube});
    }
}
}
