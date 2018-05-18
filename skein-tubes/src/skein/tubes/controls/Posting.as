/**
 * Created by max.rozdobudko@gmail.com on 5/18/18.
 */
package skein.tubes.controls {
import flash.events.NetStatusEvent;
import flash.net.NetGroup;

import skein.core.skein_internal;

use namespace skein_internal;

public class Posting {

    // Constructor

    public function Posting() {
        super();
    }

    // Connection

    protected var group: NetGroup;

    skein_internal function setGroup(value:NetGroup):void {
        if (group) {
            group.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
        }

        group = value;

        if (group) {
            group.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
        }
    }

    // Subscription

    protected var _subscribers: Vector.<Function> = new <Function>[];

    public function subscribe(handler: Function): Boolean {
        if (_subscribers.indexOf(handler) != -1) {
            return false;
        }
        _subscribers[_subscribers.length] = handler;
        return true;
    }

    public function unsubscribe(handler: Function): Boolean {
        var index: int = _subscribers.indexOf(handler);
        if (index == -1) {
            return false;
        }
        _subscribers.removeAt(_subscribers.indexOf(handler));
        return true;
    }

    private function notifySubscribers(message: Object, messageId: String): void {
        for each (var handler: Function in _subscribers) {
            if (handler.length == 2) {
                handler(message, messageId);
            } else if (handler.length == 1) {
                handler(message);
            } else {
                handler();
            }
        }
    }

    // Sending

    public function post(message: Object): Boolean {
        var messageId: String = group.post(message);
        return messageId != null;
    }

    // Handlers

    private function handleNotify(message: Object, messageId: String): void {
        notifySubscribers(message, messageId);
    }

    // Event handlers

    private function netStatusHandler(event:NetStatusEvent):void {
        switch (event.info.code) {
            case "NetGroup.Posting.Notify":
                handleNotify(event.info.message, event.info.messageID);
                break;
        }
    }
}
}
