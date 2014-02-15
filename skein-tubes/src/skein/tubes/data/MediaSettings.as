/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 12/26/13
 * Time: 5:27 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes.data
{
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.media.Camera;
import flash.media.Microphone;
import flash.media.VideoStreamSettings;

[Event(name="change", type="flash.events.Event")]

public interface MediaSettings extends IEventDispatcher
{
    function get isCameraMuted():Boolean;
    function set isCameraMuted(value:Boolean):void;

    function get isMicrophoneMuted():Boolean;
    function set isMicrophoneMuted(value:Boolean):void;

    function get video():VideoStreamSettings;
    function get camera():Camera;
    function get microphone():Microphone;

    function setCamera(value:Camera):void;
    function setMicrophone(value:Microphone):void;

    function getCameraPosition():String;
}
}
