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
import skein.tubes.data.MediaSettingsBase;

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
    //  Class functions
    //
    //--------------------------------------------------------------------------

    private static var _server:String;

    skein_internal static function server(value:String):void
    {
        _server = value;
    }

    private static var writers:Dictionary = new Dictionary();

    skein_internal static function setWriter(type:Class, generator:Object):void
    {
        writers[type] = generator;
    }

    private static var readers:Dictionary = new Dictionary();

    skein_internal static function setReader(type:Class, generator:Object):void
    {
        readers[type] = generator;
    }

    //--------------------------------------------------------------------------
    //
    //  Shared Instance
    //
    //--------------------------------------------------------------------------

    private static var instance:Config;

    public static function sharedInstance():Config
    {
        if (instance == null)
            instance = new Config();

        return instance;
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Config()
    {
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

    public function get server():String
    {
        return _server;
    }

    //-----------------------------------
    //  settings
    //-----------------------------------

    private var _settings:MediaSettingsBase;

    public function get settings():MediaSettingsBase
    {
        return _settings;
    }

    public function set settings(value:MediaSettingsBase):void
    {
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

    public function getWriter(type:Class):ShareWriter
    {
        var generator:Object = writers[type];

        if (generator is Class)
        {
            return new generator();
        }
        else if (generator is ShareWriter)
        {
            return generator as ShareWriter;
        }
        else
        {
            return null;
        }
    }

    //-------------------------------------
    //  Methods: readers
    //-------------------------------------

    public function getReader(type:Class):ShareReader
    {
        var generator:Object = readers[type];

        if (generator is Class)
        {
            return new generator();
        }
        else if (generator is ShareReader)
        {
            return generator as ShareReader;
        }
        else
        {
            return null;
        }
    }
}
}
