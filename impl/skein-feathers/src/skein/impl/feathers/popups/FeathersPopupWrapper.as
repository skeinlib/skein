/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/18/13
 * Time: 2:38 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.popups
{
import feathers.core.IValidating;
import feathers.core.PopUpManager;

import flash.events.Event;

import flash.events.EventDispatcher;
import flash.geom.Point;

import skein.popups.*;
import skein.popups.PopupWrapper;
import skein.popups.enum.PopupPosition;
import skein.popups.events.PopupEvent;
import skein.utils.PropertyProxy;

import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.Stage;
import starling.events.ResizeEvent;

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
    //--------------------------------------------------------------------------
    //
    //	Constructor
    //
    //--------------------------------------------------------------------------

    public function FeathersPopupWrapper()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //	Variables
    //
    //--------------------------------------------------------------------------

    private var child:DisplayObject;

    private var popupData:Object;

    //--------------------------------------------------------------------------
    //
    //	Properties
    //
    //--------------------------------------------------------------------------

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

        dispatchEvent(new Event("modalChanged"));
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

        if (_position != PopupPosition.FREE)
        {
            return;
        }

        _center = value;

        dispatchEvent(new Event("centerChanged"));
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

        dispatchEvent(new Event("reuseChanged"));
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

        dispatchEvent(new Event("positionChanged"));
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

        dispatchEvent(new Event("openChanged"));
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

    //----------------------------------
    //	origin
    //----------------------------------

    private var _origin:Object;

    [Bind(event="originChanged")]
    public function get origin():Object
    {
        return _origin;
    }

    public function set origin(value:Object):void
    {
        if (value == _origin) return;

        _origin = value;

        dispatchEvent(new Event("originChanged"));
    }

    //----------------------------------
    //	popupProperties
    //----------------------------------

    protected var _popupProperties:PropertyProxy;

    public function get popupProperties():Object
    {
        if (!_popupProperties)
        {
            _popupProperties = new PropertyProxy(popupPropertiesChangeCallback);
        }

        return _popupProperties;
    }

    public function set popupProperties(value:Object):void
    {
        if (_popupProperties == value)
        {
            return;
        }

        if (!value)
        {
            value = new PropertyProxy();
        }

        if (!(value is PropertyProxy))
        {
            const newValue:PropertyProxy = new PropertyProxy();

            for(var propertyName:String in value)
            {
                newValue[propertyName] = value[propertyName];
            }

            value = newValue;
        }

        if (_popupProperties)
        {
            _popupProperties.removeOnChangeCallback(popupPropertiesChangeCallback);
        }

        _popupProperties = PropertyProxy(value);

        if (_popupProperties)
        {
            _popupProperties.addOnChangeCallback(popupPropertiesChangeCallback);
        }
    }

    //--------------------------------------------------------------------------
    //
    //	Properties: feathers
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  overlayFactory
    //------------------------------------

    private var _overlayFactory:Function;

    public function get overlayFactory():Function
    {
        return _overlayFactory;
    }

    public function set overlayFactory(value:Function):void
    {
        _overlayFactory = value;
    }

    //--------------------------------------------------------------------------
    //
    //	Methods
    //
    //--------------------------------------------------------------------------

    private function openPopup():void
    {
        if (child == null || !reuse)
        {
            child = getPopup();

            refreshPopupProperties();
        }

        child.addEventListener("close", child_closeHandler);

        PopUpManager.root.stage.addEventListener(ResizeEvent.RESIZE, stage_resizeHandler);

        dispatchPopupEvent(PopupEvent.OPENING);

        PopUpManager.addPopUp(child, _modal, _center, _overlayFactory);

        layoutPopup();

        dispatchPopupEvent(PopupEvent.OPENED);
    }

    private function closePopup():void
    {
        if (!child) return;

        child.removeEventListener("close", child_closeHandler);

        PopUpManager.root.stage.removeEventListener(ResizeEvent.RESIZE, stage_resizeHandler);

        dispatchPopupEvent(PopupEvent.CLOSING);

        if (PopUpManager.isPopUp(child))
        {
            PopUpManager.removePopUp(child, !reuse);
        }

        dispatchPopupEvent(PopupEvent.CLOSED, popupData);

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
        if (_position == PopupPosition.FREE)
            return;

        var stage:Stage = Starling.current.stage;

        var origin:DisplayObject = _origin as DisplayObject;

        var position:Point = origin ? origin.localToGlobal(new Point(0, 0)) : new Point(0, 0);
        var width:Number = origin ? origin.width : stage.stageWidth;
        var height:Number = origin ? origin.height : stage.stageHeight;

        switch (_position)
        {
            case PopupPosition.LEFT :
                    child.x = position.x;
                    child.y = position.y;
                    child.height = height;
                break;

            case PopupPosition.TOP :
                child.x = position.x;
                child.y = position.y;
                child.width = width;
                break;

            case PopupPosition.RIGHT :
                    child.y = position.y;
                    child.height = height;

                    if (child is IValidating)
                        IValidating(child).validate();

                    child.x = position.x + width - child.width;
                break;

            case PopupPosition.BOTTOM :
                    child.x = position.x;
                    child.width = width;

                    if (child.hasOwnProperty("maxHeight"))
                    {
                        child["maxHeight"] = height;
                    }

                    if (child is IValidating)
                        IValidating(child).validate();

                    child.y = position.y + height - child.height;
                break;

            case PopupPosition.FILL :
                    child.x = position.x;
                    child.y = position.y;
                    child.width = width;
                    child.height = height;
                break;
        }
    }

    private function dispatchPopupEvent(type:String, withData:Object=null):void
    {
        dispatchEvent(new PopupEvent(type, false, withData));
    }

    //------------------------------------------------------------------------
    //
    //	Callbacks
    //
    //------------------------------------------------------------------------

    protected function popupPropertiesChangeCallback(proxy:PropertyProxy, name:String):void
    {
        refreshPopupProperties();
    }

    private function refreshPopupProperties():void
    {
        if (child != null)
        {
            for (var name:String in _popupProperties)
            {
                if (child.hasOwnProperty(name))
                {
                    var value:Object = _popupProperties[name];

                    child[name] = value;
                }
            }
        }
    }

    //------------------------------------------------------------------------
    //
    //	Handlers
    //
    //------------------------------------------------------------------------

    //-------------------------------------
    //  Handlers: child
    //-------------------------------------

    private function child_closeHandler(event:Object):void
    {
        if (event && event.hasOwnProperty("data"))
        {
            popupData = event.data;
        }

        open = false;
    }

    //-------------------------------------
    //  Handlers: stage
    //-------------------------------------

    private function stage_resizeHandler(event:ResizeEvent):void
    {
        layoutPopup();
    }
}
}
