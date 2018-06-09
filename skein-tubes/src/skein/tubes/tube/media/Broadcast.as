/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 12/26/13
 * Time: 2:15 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes.tube.media
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.media.Camera;
import flash.net.NetStream;

import skein.core.skein_internal;
import skein.tubes.core.Connector;
import skein.tubes.enum.CameraPosition;
import skein.tubes.tube.media.settings.MediaSettings;

use namespace skein_internal;

public class Broadcast extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Broadcast(connector: Connector, name: String, settings: MediaSettings = null, autoPublish: Boolean = true) {
        super();

        _connector = connector;
        _connector.whenConnected(function(): void {
            if (_connector) {
                setStream(new NetStream(_connector.connection, _connector.specifier.groupspecWithAuthorizations()));
            }
        });

        _name = name;

        _settings = settings;// || Config.shared.settings;
        _settings.addEventListener(Event.CHANGE, settings_changeHandler);

        if (autoPublish) {
            publish();
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Dependencies
    //
    //--------------------------------------------------------------------------

    private var _connector: Connector;

    private var _settings: MediaSettings;

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  name
    //-------------------------------------

    private var _name:String;
    public function get name():String {
        return _name;
    }

    //-------------------------------------
    //  stream
    //-------------------------------------

    private var _stream:NetStream;
    [Bindable(event="streamChanged")]
    public function get stream():NetStream
    {
        return _stream;
    }
    skein_internal function setStream(value:NetStream):void {
        _stream = value;

        if (_stream != null) {
            if (_isPublishing) {
                _stream.publish(_name);
                update();
            }
        }

        dispatchEvent(new Event("streamChanged"));
    }

    //-------------------------------------
    //  camera
    //-------------------------------------

    [Bind(event="change")]
    public function get camera():Camera {
        return _settings ? _settings.camera : null;
    }

    //-------------------------------------
    //  muted
    //-------------------------------------

    public function get muted():Boolean {
        return _settings.isCameraMuted || _settings.isMicrophoneMuted;
    }

    //-------------------------------------
    //  active
    //-------------------------------------

    public function get active():Boolean {
        return !_settings.isCameraMuted || !_settings.isMicrophoneMuted;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    private var _isPublishing: Boolean = false;
    public function get isPublishing(): Boolean {
        return _isPublishing;
    }

    public function publish():void {
        if (_isPublishing) {
            return;
        }

        _isPublishing = true;

        if (_stream != null) {
            _stream.publish(name);
        }
    }

    private var _isPaused: Boolean = false;
    public function get isPaused(): Boolean {
        return _isPaused;
    }

    public function pause():void {
        if (_isPaused) {
            return;
        }

        _isPaused = true;

        update();
    }

    public function resume():void {
        if (!_isPaused) {
            return;
        }

        _isPaused = false;

        update();
    }

    public function toggle():void {
        if (_isPaused) {
            resume();
        } else {
            pause();
        }
    }

    public function mute():void {
        muteCamera();
        muteMicrophone();
    }

    public function unmute():void {
        unmuteCamera();
        unmuteMicrophone();
    }

    //--------------------------------------
    //  MARK: Close and Dispose
    //--------------------------------------

    public function close():void {
        if (_stream != null) {
            _stream.attachAudio(null);
            _stream.attachCamera(null);
            _stream.close();
        }

        dispatchEvent(new Event(Event.CLOSE));
    }

    public function dispose(): void {
        _connector = null;

        close();

        if (_stream) {
            _stream.dispose();
            _stream = null;
        }

        _settings.removeEventListener(Event.CHANGE, settings_changeHandler);
        _settings = null;
    }

    //--------------------------------------
    //  MARK: camera
    //--------------------------------------

    public function toggleCamera():void {
        if (_settings.isCameraMuted) {
            unmuteCamera();
        } else {
            muteCamera();
        }
    }

    public function muteCamera():void {
        if (_settings.isCameraMuted) {
            return;
        }

        _settings.isCameraMuted = true;

        updateCamera();
    }

    public function unmuteCamera():void {
        if (!_settings.isCameraMuted) {
            return;
        }

        _settings.isCameraMuted = false;

        updateCamera();
    }

    public function switchCamera():void {
        if (Camera.names.length < 2) {
            return;
        }

        var current:String = _settings.getCameraPosition();

        if (current == CameraPosition.FRONT) {
            switchCameraBack();
        } else if (current == CameraPosition.BACK) {
            switchCameraFront();
        }
    }

    public function switchCameraBack():void {
        for (var i:uint = 0; i < Camera.names.length; ++i) {
            var camera:Camera = Camera.getCamera(String(i));
            if (camera.hasOwnProperty("position") && camera.position == CameraPosition.BACK) {
                _settings.setCamera(camera);
                return;
            }
        }
    }

    public function switchCameraFront():void {
        for (var i:uint = 0; i < Camera.names.length; ++i) {
            var camera:Camera = Camera.getCamera(String(i));
            if (camera.hasOwnProperty("position") && camera.position == CameraPosition.FRONT) {
                _settings.setCamera(camera);
                return;
            }
        }
    }

    //--------------------------------------
    //  Methods: microphone
    //--------------------------------------

    public function toggleMicrophone():void {
        if (_settings.isMicrophoneMuted)
            unmuteMicrophone();
        else
            muteMicrophone();
    }

    public function muteMicrophone():void {
        if (_settings.isMicrophoneMuted) {
            return;
        }

        _settings.isMicrophoneMuted = true;

        updateMicrophone();
    }

    public function unmuteMicrophone():void {
        if (!_settings.isMicrophoneMuted) {
            return;
        }

        _settings.isMicrophoneMuted = false;

        updateMicrophone();
    }

    //--------------------------------------
    //  Methods: update
    //--------------------------------------

    private function update():void {
        updateCamera();
        updateMicrophone();
    }

    private function updateCamera():void {
        if (_stream == null) {
            return;
        }

        if (_isPaused || _settings.isCameraMuted) {
            _stream.attachCamera(null);
        } else {
            _stream.attachCamera(_settings.camera);
        }
    }

    private function updateMicrophone():void {
        if (_stream == null) {
            return;
        }

        if (_isPaused || _settings.isMicrophoneMuted) {
            _stream.attachAudio(null);
        } else {
            _stream.attachAudio(_settings.microphone);
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //--------------------------------------------------------------------------

    private function settings_changeHandler(event:Event):void {
        update();
        dispatchEvent(new Event("change"));
    }
}
}
