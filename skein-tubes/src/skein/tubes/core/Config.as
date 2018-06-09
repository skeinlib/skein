/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 12/26/13
 * Time: 5:09 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes.core
{
import flash.utils.Dictionary;

import skein.core.skein_internal;
import skein.tubes.tube.media.settings.MediaSettings;
import skein.tubes.tube.sharing.replication.ShareReader;
import skein.tubes.tube.sharing.replication.ShareWriter;

use namespace skein_internal;

public class Config
{
    //--------------------------------------------------------------------------
    //
    //  Class variables
    //
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    //
    //  Contracts
    //
    //--------------------------------------------------------------------------

    private static var writers:Dictionary = new Dictionary();
    skein_internal static function setWriter(type:Class, generator:Object):void {
        writers[type] = generator;
    }

    private static var readers:Dictionary = new Dictionary();
    skein_internal static function setReader(type:Class, generator:Object):void {
        readers[type] = generator;
    }

    //--------------------------------------------------------------------------
    //
    //  Shared Instance
    //
    //--------------------------------------------------------------------------

    private static var instance:Config;
    public static function get shared():Config {
        if (instance == null) {
            instance = new Config();
        }

        return instance;
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Config() {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-----------------------------------
    //  server
    //-----------------------------------

    private static var _address: String = "rtmfp://p2p.rtmfp.net/4eac03fdddf60bb5e7df9cb3-c21addd5ccab";
    public function get address(): String {
        return _address;
    }
    skein_internal function set address(value: String): void {
        _address = value;
    }

    //-----------------------------------
    //  settings
    //-----------------------------------

    private var _settings: MediaSettings;
    public function get settings(): MediaSettings {
        return _settings;
    }
    skein_internal function set settings(value: MediaSettings):void {
        _settings = value;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Methods: writers
    //-------------------------------------

    public function getWriter(Type: Class): ShareWriter {
        var Generator: Object = writers[Type];

        if (Generator is Class) {
            return new Generator();
        } else if (Generator is ShareWriter) {
            return Generator as ShareWriter;
        }

        return null;
    }

    //-------------------------------------
    //  Methods: readers
    //-------------------------------------

    public function getReader(Type: Class): ShareReader {
        var Generator: Object = readers[Type];

        if (Generator is Class) {
            return new Generator();
        } else if (Generator is ShareReader) {
            return Generator as ShareReader;
        }

        return null;
    }
}
}
