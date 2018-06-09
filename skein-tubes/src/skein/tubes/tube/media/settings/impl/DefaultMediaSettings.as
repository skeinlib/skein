/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 12/27/13
 * Time: 10:42 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes.tube.media.settings.impl
{
import skein.tubes.tube.media.settings.*;

import flash.media.Camera;
import flash.media.Microphone;
import flash.media.SoundCodec;
import flash.media.VideoStreamSettings;

import skein.tubes.tube.media.settings.MediaSettingsBase;

public class DefaultMediaSettings extends MediaSettingsBase
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function DefaultMediaSettings()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    //--------------------------------------
    //  Overridden methods: video
    //--------------------------------------

    override protected function createDefaultVideo():VideoStreamSettings
    {
        return new VideoStreamSettings();
    }

    //--------------------------------------
    //  Overridden methods: camera
    //--------------------------------------

    override protected function createDefaultCamera():Camera
    {
        var camera:Camera = Camera.getCamera();

        applyCameraSettings(camera);

        return camera;
    }

    override protected function applyCameraSettings(camera:Camera):void
    {
        if (camera)
        {
            camera.setMode(320, 240, 16, true);
            camera.setLoopback(true);
            camera.setKeyFrameInterval(15);
            camera.setQuality(0, 50);
        }
    }

    //--------------------------------------
    //  Overridden methods: microphone
    //--------------------------------------

    override protected function createDefaultMicrophone():Microphone
    {
        var microphone:Microphone = Microphone.getEnhancedMicrophone() || Microphone.getMicrophone();

        applyMicrophoneSettings(microphone);

        return microphone;
    }

    override protected function applyMicrophoneSettings(microphone:Microphone):void
    {
        if (microphone)
        {
            microphone.codec = SoundCodec.PCMU;
            microphone.setLoopBack(false);
            microphone.setSilenceLevel(10, 20000);
            microphone.gain = 60;

//            if (microphone.codec == SoundCodec.SPEEX)
//            {
//                microphone.codec = SoundCodec.SPEEX;
//                microphone.enableVAD = true;
//                microphone.encodeQuality = 6;
//                microphone.framesPerPacket = 1;
//                microphone.noiseSuppressionLevel = -30; // dB (default -30)
//            }
//
//            microphone.rate = 8; //kHz (default 8)
//            microphone.setSilenceLevel(0, 2000);
//            microphone.gain = 50.0;
//            microphone.setUseEchoSuppression(true);
        }
    }
}
}
