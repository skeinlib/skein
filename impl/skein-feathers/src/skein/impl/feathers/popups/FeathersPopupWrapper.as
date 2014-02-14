/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/18/13
 * Time: 2:38 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.popups
{
import feathers.core.PopUpManager;

import flash.events.Event;

import flash.events.EventDispatcher;

import skein.popups.*;
import skein.popups.enum.PopupPosition;
import skein.popups.events.PopupEvent;

import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.Stage;

/**
 * Dispatched after the popup has been created but just before it is added to
 * the display list.
 */
[Event(name="opening", type="skein.popups.events.PopupEvent")]

/**
 * Dispatched just after the popup has added to the display list.
 */
[Event(name="opened", type="skein.popups.events.PopupEvent")]

/**
 * Dispatched just before the popup is removed from the display list.
 */
[Event(name="closing", type="skein.popups.events.PopupEvent")]

/**
 * Dispatched just after the popup is removed from the display list.
 */
[Event(name="closed", type="skein.popups.events.PopupEvent")]

public class FeathersPopupWrapper extends EventDispatcher implements PopupWrapper
{
    //------------------------------------------------------------------------
    //
    //	Constructor
    //
    //------------------------------------------------------------------------

    public function FeathersPopupWrapper()
    {
        super();
    }

    //------------------------------------------------------------------------
    //
    //	Variables
    //
    //------------------------------------------------------------------------

    private var child:DisplayObject;

    private var popupData:Object;

    //------------------------------------------------------------------------
    //
    //	Properties
    //
    //------------------------------------------------------------------------

    //----------------------------------
    //	modal
    //----------------------------------

    private var _modal:Boolean;

    [Bind(event="modalChanged")]
    public function get modal():Boolean
    {
        return _modal;
    }

    public function set modal(value:Boolean):void
    {
        if (value == _modal) return;

        _modal = value;

        this.dispatchEvent(new Event("modalChanged"));
    }

    //----------------------------------
    //	center
    //----------------------------------

    private var _center:Boolean;

    [Bind(event="centerChanged")]
    public function get center():Boolean
    {
        return _center;
    }

    public function set center(value:Boolean):void
    {
        if (value == _center) return;

        if (this.position != PopupPosition.FREE)
        {
            return;
        }

        _center = value;

        this.dispatchEvent(new Event("centerChanged"));
    }

    //----------------------------------
    //	reuse
    //----------------------------------

    private var _reuse:Boolean = false;

    [Bind(event="reuseChanged")]
    public function get reuse():Boolean
    {
        return _reuse;
    }

    public function set reuse(value:Boolean):void
    {
        if (value == _reuse) return;

        _reuse = value;

        this.dispatchEvent(new Event("reuseChanged"));
    }

    //----------------------------------
    //	position
    //----------------------------------

    private var _position:String = PopupPosition.FREE;

    [Bind(event="positionChanged")]
    public function get position():String
    {
        return _position;
    }

    public function set position(value:String):void
    {
        if (value == _position) return;

        _position = value;

        this.dispatchEvent(new Event("positionChanged"));
    }

    //----------------------------------
    //	open
    //----------------------------------

    private var _open:Boolean;

    [Bind(event="openChanged")]
    public function get open():Boolean
    {
        return _open;
    }

    public function set open(value:Boolean):void
    {
        if (value == _open) return;

        _open = value;

        if (_open)
        {
            openPopup();
        }
        else
        {
            closePopup();
        }

        this.dispatchEvent(new Event("openChanged"));
    }

    //----------------------------------
    //	popup
    //----------------------------------

    private var _popup:Object;

    public function get popup():Object
    {
        return _popup;
    }

    public function set popup(value:Object):void
    {
        if (value == _popup) return;

        _popup = value;
    }

    //------------------------------------------------------------------------
    //
    //	Methods
    //
    //------------------------------------------------------------------------

    private function openPopup():void
    {
        if (child == null || !reuse)
            child = getPopup();

        child.addEventListener(Event.CLOSE, child_closeHandler);

        dispatchPopupEvent(PopupEvent.OPENING);

        PopUpManager.addPopUp(this.child, this.modal, this.center);

        this.layoutPopup();

        dispatchPopupEvent(PopupEvent.OPENED);
    }

    private function closePopup():void
    {
        if (!this.child) return;

        this.child.removeEventListener("close", child_closeHandler);

        this.dispatchPopupEvent(PopupEvent.CLOSING);

        PopUpManager.removePopUp(this.child, !this.reuse);

        this.dispatchPopupEvent(PopupEvent.CLOSED, popupData);

        popupData = null;
    }

    private function getPopup():DisplayObject
    {
        if (_popup is Class)
        {
            var PopupClass:Class = _popup as Class;

            return new PopupClass();
        }
        else if (_popup is Function)
        {
            var popupFunction:Function = _popup as Function;

            return popupFunction() as DisplayObject;
        }
        else
        {
            return _popup as DisplayObject;
        }
    }

    private function layoutPopup():void
    {
        if (this.position == PopupPosition.FREE)
            return;

        var stage:Stage = Starling.current.stage;

        switch (this.position)
        {
            case PopupPosition.LEFT :
                    this.child.x = 0
                    this.child.y = 0;
                    this.child.height = stage.height;
                break;

            case PopupPosition.TOP :
                    this.child.x = 0
                    this.child.y = 0;
                    this.child.width = stage.width;
                break;

            case PopupPosition.RIGHT :
                    this.child.x = stage.width - this.child.width;
                    this.child.y = 0;
                    this.child.height = stage.height;
                break;

            case PopupPosition.BOTTOM :
                    this.child.x = 0
                    this.child.y = stage.height - this.child.height;
                    this.child.width = stage.width;
                break;

            case PopupPosition.FILL :
                    this.child.x = 0
                    this.child.y = 0;
                    this.child.width = stage.width;
                    this.child.height = stage.height;
                break;
        }
    }

    private function dispatchPopupEvent(type:String, withData:Object=null):void
    {
        this.dispatchEvent(new PopupEvent(type, false, withData));
    }

    //------------------------------------------------------------------------
    //
    //	Handlers
    //
    //------------------------------------------------------------------------

    private function child_closeHandler(event:Object):void
    {
        if (event && event.hasOwnProperty("data"))
        {
            popupData = event.data;
        }

        this.open = false;
    }
}
}
