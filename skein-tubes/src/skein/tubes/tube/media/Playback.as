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
import flash.net.NetStream;

import skein.core.skein_internal;
import skein.tubes.core.Connector;

use namespace skein_internal;

public class Playback extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Playback(connector: Connector, name:String, autoPlay:Boolean = true)
    {
        super();

        _connector = connector;
        _connector.whenConnected(function(): void {
            if (_connector) {
                setStream(new NetStream(_connector.connection, _connector.specifier.groupspecWithAuthorizations()));
            }
        });

        _name = name;

        if (autoPlay) {
            play();
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Dependencies
    //
    //--------------------------------------------------------------------------

    protected var _connector: Connector;

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

    private var _stream: NetStream;
    [Bindable(event="streamChanged")]
    public function get stream(): NetStream {
        return _stream;
    }
    skein_internal function setStream(value:NetStream):void {
        _stream = value;

        if (_stream != null) {
            if (_isPlaying) {
                _stream.play(_name);
            }

            if (_isPaused) {
                _stream.pause();
            }
        }

        dispatchEvent(new Event("streamChanged"));
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  MARK: Playback control
    //-------------------------------------

    private var _isPlaying:Boolean = false;
    public function get isPlaying(): Boolean {
        return _isPlaying;
    }

    public function play():void {
        if (_isPlaying) {
            return;
        }

        _isPlaying = true;

        if (_stream != null) {
            _stream.play(_name);
        }
    }

    private var _isPaused:Boolean = false;
    public function get isPaused(): Boolean {
        return _isPaused;
    }

    public function pause():void {
        if (_isPaused) {
            return;
        }

        _isPaused = true;

        if (_stream) {
            _stream.pause();
        }
    }

    public function resume():void {
        if (!_isPaused) {
            return;
        }

        _isPaused = false;

        if (_stream != null) {
            _stream.resume();
        }
    }

    //-------------------------------------
    //  MARK: Close and Dispose
    //-------------------------------------

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
    }
}
}
