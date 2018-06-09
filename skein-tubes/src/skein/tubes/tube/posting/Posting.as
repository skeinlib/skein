/**
 * Created by max.rozdobudko@gmail.com on 5/18/18.
 */
package skein.tubes.tube.posting {
import flash.events.NetStatusEvent;

import skein.core.skein_internal;
import skein.tubes.core.emitter.Emitter;
import skein.tubes.core.emitter.EmitterEvent;
import skein.tubes.tube.Tube;

use namespace skein_internal;

public class Posting extends Emitter {

    //--------------------------------------------------------------------------
    //
    // Constructor
    //
    //--------------------------------------------------------------------------

    public function Posting(tube: Tube) {
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
    //  MARK: Post
    //-------------------------------------

    public function emit(event: String, message: Object, callback: Function = null): void {
        _tube.neighborhood.whenNotAlone(function (): void {
            var messageId: String = _tube.connector.group.post({event: event, payload: message, from: _tube.connector.myId});
            if (callback != null) {
                callback(messageId);
            }
        });
    }

    public function send(message: Object, callback: Function = null): void {
        emit(EmitterEvent.MESSAGE, message, callback);
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

    private function netStatusHandler(event:NetStatusEvent):void {
        switch (event.info.code) {
            case "NetGroup.Posting.Notify":
                notifySubscribers(event.info.message, {tube: _tube, messageId: event.info.messageID});
                break;
        }
    }
}
}
