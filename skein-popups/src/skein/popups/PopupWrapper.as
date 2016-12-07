/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/19/13
 * Time: 4:27 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.popups
{
public interface PopupWrapper
{
    [Bind(event="openChanged")]
    function get open():Boolean;
    function set open(value:Boolean):void;

    [Bind(event="modalChanged")]
    function get modal():Boolean;
    function set modal(value:Boolean):void;

    [Bind(event="centerChanged")]
    function get center():Boolean;
    function set center(value:Boolean):void;

    [Bind(event="reuseChanged")]
    function get reuse():Boolean;
    function set reuse(value:Boolean):void;

    [Bind(event="positionChanged")]
    function get position():String;
    function set position(value:String):void;

    function get popup():Object;
    function set popup(value:Object):void

    function get origin():Object;
    function set origin(value:Object):void

    function get popupProperties():Object;
    function set popupProperties(value:Object):void;

    function get paddingLeft():Number;
    function set paddingLeft(value:Number):void;

    function get paddingTop():Number;
    function set paddingTop(value:Number):void;

    function get paddingRight():Number;
    function set paddingRight(value:Number):void;

    function get paddingBottom():Number;
    function set paddingBottom(value:Number):void;
}
}
