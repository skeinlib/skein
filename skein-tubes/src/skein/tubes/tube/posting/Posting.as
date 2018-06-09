/**
 * Created by max.rozdobudko@gmail.com on 5/18/18.
 */
package skein.tubes.tube.posting {
import flash.events.NetStatusEvent;
import flash.net.NetGroup;

import skein.core.skein_internal;
import skein.tubes.core.Connector;
import skein.tubes.core.emitter.Emitter;
import skein.tubes.core.emitter.EmitterEvent;

use namespace skein_internal;

public class Posting extends Emitter {

    //--------------------------------------------------------------------------
    //
    // Constructor
    //
    //--------------------------------------------------------------------------

    public function Posting(connector: Connector) {
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
    //  MARK: Post
    //-------------------------------------

    public function emit(event: String, message: Object, callback: Function = null): void {
        _connector.whenConnected(function (): void {
            var messageId: String = _connector.group.post({event: event, payload: message, from: _connector.myId});
            if (callback != null) {
                callback(messageId);
            }
        });
    }

    public function send(message: Object, callback: Function = null): void {
        emit("message", message, callback);
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
            case "NetGroup.Posting.Notify":
                notifySubscribers(event.info.message, {messageId: event.info.messageID});
                break;
        }
    }
}
}
