/**
 * Created by max.rozdobudko@gmail.com on 6/8/18.
 */
package skein.tubes.core.emitter {
import flash.events.EventDispatcher;

import skein.logger.Log;

public class Emitter extends EventDispatcher {

    // Constructor

    public function Emitter() {
        super();
    }

    // Variables

    protected var _subscribersMap: Object = {};

    // Methods

    public function on(event: String, handler: Function): void {
        if (_subscribersMap == null) {
            _subscribersMap = {};
        }

        var handlers: Vector.<Function> = _subscribersMap[event];
        if (handlers == null) {
            _subscribersMap[event] = new <Function>[handler];
        } else if (handlers.indexOf(handler) == -1){
            handlers.push(handler);
        }
    }

    public function off(event: String = null, handler: Function = null): void {
        if (event == null && handlers == null) {
            _subscribersMap = {};
        }

        if (_subscribersMap == null) {
            return;
        }

        if (event == null) {
            return;
        }

        var handlers: Vector.<Function> = _subscribersMap[event];
        if (handlers == null || handlers.length == 0) {
            return;
        }

        if (handler == null) {
            _subscribersMap[event] = null;
            delete  _subscribersMap[event];
        } else {
            var index: int = handlers.indexOf(handler);
            if (index != -1) {
                handlers.removeAt(index);
            }
        }
    }

    protected function notifySubscribers(message: Object, info: Object): void {
        if (message == null) {
            return;
        }

        var from: String    = message.from;
        var to: String      = message.to;
        var event: String   = message.event;
        var payload: Object = message.payload;

        Log.d("skein-tubes", "Event \""+event+"\" with payload \""+payload+"\" received from " + from);

        if (_subscribersMap == null) {
            return;
        }

        info = info || {};
        info.to = to;

        var handlers: Vector.<Function> = _subscribersMap[event];
        if (handlers == null || handlers.length == 0) {
            return;
        }

        for (var i: int = 0; i < handlers.length; i++) {
            var handler: Function = handlers[i];
            if (handler.length == 4) {
                handler(payload, from, info.tube, info);
            } else if (handler.length == 3) {
                handler(payload, from, info.tube)
            } else if (handler.length == 2) {
                handler(payload, from);
            } else if (handler.length == 1) {
                handler(payload);
            } else {
                handler();
            }
        }
    }
}
}
