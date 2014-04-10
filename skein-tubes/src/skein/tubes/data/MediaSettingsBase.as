/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 12/27/13
 * Time: 10:36 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes.data
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.media.Camera;
import flash.media.Microphone;
import flash.media.SoundCodec;
import flash.media.VideoStreamSettings;

import skein.tubes.enum.CameraPosition;

public class MediaSettingsBase extends EventDispatcher implements MediaSettings
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function MediaSettingsBase()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //--------------------------------------
    //  isCameraMuted
    //--------------------------------------

    private var _isCameraMuted:Boolean;

    public function get isCameraMuted():Boolean
    {
        return _isCameraMuted;
    }

    public function set isCameraMuted(value:Boolean):void
    {
        _isCameraMuted = value;
    }

    //--------------------------------------
    //  isCameraFront
    //--------------------------------------

    public function get isCameraFront():Boolean
    {
        return getCameraPosition() == CameraPosition.FRONT;
    }

    //--------------------------------------
    //  isMicrophoneMuted
    //--------------------------------------

    private var _isMicrophoneMuted:Boolean;

    public function get isMicrophoneMuted():Boolean
    {
        return _isMicrophoneMuted;
    }

    public function set isMicrophoneMuted(value:Boolean):void
    {
        _isMicrophoneMuted = value;
    }

    //--------------------------------------
    //  video
    //--------------------------------------

    private var _video:VideoStreamSettings;

    [Bindable(event="videoChanged")]
    public function get video():VideoStreamSettings
    {
        if (!_video)
        {
            _video = createDefaultVideo();
        }

        return _video;
    }

    public function setVideo(value:VideoStreamSettings):void
    {
        if (value == _video) return;

        _video = value;

        dispatchEvent(new Event(Event.CHANGE));

        dispatchEvent(new Event("videoChanged"));
    }

    //--------------------------------------
    //  camera
    //--------------------------------------

    private var _camera:Camera;

    [Bindable(event="cameraChanged")]
    public function get camera():Camera
    {
        if (!_camera)
        {
            _camera = createDefaultCamera();
        }

        return _camera;
    }

    public function setCamera(value:Camera):void
    {
        if (value == _camera) return;

        _camera = value;

        applyCameraSettings(_camera);

        dispatchEvent(new Event(Event.CHANGE));

        dispatchEvent(new Event("cameraChanged"));
    }

    //--------------------------------------
    //  microphone
    //--------------------------------------

    private var _microphone:Microphone;

    [Bindable(event="microphoneChanged")]
    public function get microphone():Microphone
    {
        if (!_microphone)
        {
            _microphone = createDefaultMicrophone();
        }

        return _microphone;
    }

    public function setMicrophone(value:Microphone):void
    {
        if (value == _microphone) return;

        _microphone = value;

        applyMicrophoneSettings(_microphone);

        dispatchEvent(new Event(Event.CHANGE));

        dispatchEvent(new Event("microphoneChanged"));
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function getCameraPosition():String
    {
        return _camera ? _camera.position : null;
    }

    //--------------------------------------------------------------------------
    //
    //  Abstract methods
    //
    //--------------------------------------------------------------------------

    //--------------------------------------
    //  Abstract methods: video
    //--------------------------------------

    protected function createDefaultVideo():VideoStreamSettings
    {
        return null;
    }

    //--------------------------------------
    //  Abstract methods: camera
    //--------------------------------------

    protected function createDefaultCamera():Camera
    {
        return null;
    }

    protected function applyCameraSettings(camera:Camera):void
    {

    }

    //--------------------------------------
    //  Abstract methods: microphone
    //--------------------------------------

    protected function createDefaultMicrophone():Microphone
    {
        return null;
    }

    protected function applyMicrophoneSettings(microphone:Microphone):void
    {

    }
}
}
