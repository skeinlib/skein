/**
 * Created by Max Rozdobudko on 10/20/15.
 */
package skein.logger
{
import skein.core.skein_internal;
import skein.logger.core.Config;
import skein.logger.core.LoggerRegistry;

use namespace skein_internal;

public class Log
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    public static const DEBUG:uint = 3;

    public static const INFO:uint  = 4;

    public static const WARN:uint  = 5;

    public static const ERROR:uint = 6;

    public static const DEFAULT: uint = ERROR;

    public static const DISABLED: uint = uint.MAX_VALUE;

    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Class methods: Logging
    //-------------------------------------

    public static function d(tag:String, message:Object):void {
        if (Config.getLogLevelForTag(tag) <= DEBUG) {
            log(DEBUG, tag, message);
        }
    }

    public static function i(tag:String, message:Object):void {
        if (Config.getLogLevelForTag(tag) <= INFO) {
            log(INFO, tag, message);
        }
    }

    public static function w(tag:String, message:Object):void {
        if (Config.getLogLevelForTag(tag) <= WARN) {
            log(WARN, tag, message);
        }
    }

    public static function e(tag:String, message:Object):void {
        if (Config.getLogLevelForTag(tag) <= ERROR) {
            log(ERROR, tag, message);
        }
    }

    //-------------------------------------
    //  Class methods: Internal
    //-------------------------------------

    private static function log(level:uint, tag:String, message:Object):void {
        if (LoggerRegistry.getLogger(tag) != null) {
            LoggerRegistry.getLogger(tag).log(new LogEvent(tag, levelToString(level), message));
        }
    }

    private static function levelToString(level:uint):String {

        switch (level) {
            case DEBUG : return "DEBUG"; break;
            case INFO : return "INFO"; break;
            case WARN : return "WARN"; break;
            case ERROR : return "ERROR"; break;
            default : return "UNKNOWN"; break;
        }
    }
}
}
