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
import flash.net.NetStream;

import skein.core.skein_internal;

use namespace skein_internal;

public class Playback extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Playback(name:String, autoPlay:Boolean = true)
    {
        super();

        _name = name;

        if (autoPlay)
            play();
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var isPaused:Boolean = false;

    private var isPlaying:Boolean = false;

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
            if (isPlaying)
                _stream.play(_name);

            if (isPaused)
                _stream.pause();
        }

        dispatchEvent(new Event("streamChanged"));
    }
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function play():void
    {
        if (!isPlaying)
        {
            isPlaying = true;

            if (_stream != null)
                _stream.play(_name);
        }
    }

    public function pause():void
    {
        if (!isPaused)
        {
            isPaused = true;

            _stream.pause();
        }
    }

    public function resume():void
    {
        if (isPaused)
        {
            isPaused = false;

            if (_stream != null)
                _stream.resume();
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
}
}
