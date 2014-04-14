/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 12/26/13
 * Time: 2:15 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes.controls
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.media.Camera;
import flash.media.SoundMixer;
import flash.net.NetStream;

import skein.core.skein_internal;
import skein.tubes.core.Config;

import skein.tubes.data.MediaSettings;
import skein.tubes.data.settings.DefaultMediaSettings;
import skein.tubes.enum.CameraPosition;

public class Broadcast extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Broadcast(name:String, settings:MediaSettings=null, autoPublish:Boolean = true)
    {
        super();

        _name = name;

        this.settings = settings || Config.sharedInstance().settings;
        this.settings.addEventListener(Event.CHANGE, settings_changeHandler);

        if (autoPublish)
            publish();
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var settings:MediaSettings;

    private var isPaused:Boolean = false;

    private var isPublishing:Boolean = false;

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  name
    //-------------------------------------

    private var _name:String;

    public function get name():String
    {
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

    skein_internal function setStream(value:NetStream):void
    {
        _stream = value;

        if (_stream != null)
        {
            if (isPublishing)
            {
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
    public function get camera():Camera
    {
        return settings ? settings.camera : null;
    }

    //-------------------------------------
    //  muted
    //-------------------------------------

    public function get muted():Boolean
    {
        return settings.isCameraMuted || settings.isMicrophoneMuted;
    }

    //-------------------------------------
    //  active
    //-------------------------------------

    public function get active():Boolean
    {
        return !settings.isCameraMuted || !settings.isMicrophoneMuted;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function publish():void
    {
        if (!isPublishing)
        {
            isPublishing = true;

            if (_stream != null)
                _stream.publish(name);
        }
    }

    public function toggle():void
    {
        if (isPaused)
            resume();
        else
            pause();
    }

    public function pause():void
    {
        if (!isPaused)
        {
            isPaused = true;

            update();
        }
    }

    public function resume():void
    {
        if (isPaused)
        {
            isPaused = false;

            update();
        }
    }

    public function close():void
    {
        if (_stream != null)
        {
            _stream.attachAudio(null);
            _stream.attachCamera(null);
            _stream.close();
        }

        dispatchEvent(new Event(Event.CLOSE));
    }

    public function mute():void
    {
        muteCamera();
        muteMicrophone();
    }

    public function unmute():void
    {
        unmuteCamera();
        unmuteMicrophone();
    }

    //--------------------------------------
    //  Methods: camera
    //--------------------------------------

    public function toggleCamera():void
    {
        if (settings.isCameraMuted)
            unmuteCamera();
        else
            muteCamera();
    }

    public function muteCamera():void
    {
        if (!settings.isCameraMuted)
        {
            settings.isCameraMuted = true;

            updateCamera();
        }
    }

    public function unmuteCamera():void
    {
        if (settings.isCameraMuted)
        {
            settings.isCameraMuted = false;

            updateCamera();
        }
    }

    public function switchCamera():void
    {
        if (Camera.names.length < 2)
            return;

        var current:String = settings.getCameraPosition();

        if (current == CameraPosition.FRONT)
        {
            switchCameraBack();
        }
        else if (current == CameraPosition.BACK)
        {
            switchCameraFront();
        }
    }

    public function switchCameraBack():void
    {
        for (var i:uint = 0; i < Camera.names.length; ++i)
        {
            var camera:Camera = Camera.getCamera(String(i));

            if (camera.hasOwnProperty("position") && camera.position == CameraPosition.BACK)
            {
                settings.setCamera(camera);
                return;
            }
        }
    }

    public function switchCameraFront():void
    {
        for (var i:uint = 0; i < Camera.names.length; ++i)
        {
            var camera:Camera = Camera.getCamera(String(i));

            if (camera.hasOwnProperty("position") && camera.position == CameraPosition.FRONT)
            {
                settings.setCamera(camera);
                return;
            }
        }
    }

    //--------------------------------------
    //  Methods: microphone
    //--------------------------------------

    public function toggleMicrophone():void
    {
        if (settings.isMicrophoneMuted)
            unmuteMicrophone();
        else
            muteMicrophone();
    }

    public function muteMicrophone():void
    {
        if (!settings.isMicrophoneMuted)
        {
            settings.isMicrophoneMuted = true;

            updateMicrophone();
        }
    }

    public function unmuteMicrophone():void
    {
        if (settings.isMicrophoneMuted)
        {
            settings.isMicrophoneMuted = false;

            updateMicrophone();
        }
    }

    //--------------------------------------
    //  Methods: update
    //--------------------------------------

    private function update():void
    {
        updateCamera();
        updateMicrophone();
    }

    private function updateCamera():void
    {
        if (_stream != null)
        {
            if (isPaused || settings.isCameraMuted)
            {
                _stream.attachCamera(null);
            }
            else
            {
                _stream.attachCamera(settings.camera);
            }
        }
    }

    private function updateMicrophone():void
    {
        if (_stream != null)
        {
            if (isPaused || settings.isMicrophoneMuted)
            {
                _stream.attachAudio(null);
            }
            else
            {
                _stream.attachAudio(settings.microphone);
            }
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //--------------------------------------------------------------------------

    private function settings_changeHandler(event:Event):void
    {
        update();

        dispatchEvent(new Event("change"));
    }
}
}
