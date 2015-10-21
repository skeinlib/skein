/**
 * Created by Max Rozdobudko on 10/20/15.
 */
package skein.rest.logger
{
import skein.rest.core.Config;

public class Log
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    public static const DEBUG:uint = 3;

    public static const INFO:uint = 4;

    public static const WARN:uint = 5;

    public static const ERROR:uint = 6;

    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Class methods: Logging
    //-------------------------------------

    public static function d(tag:String, message:Object):void
    {
        if (Config.sharedInstance().logLevel <= DEBUG)
        {
            log(DEBUG, tag, message);
        }
    }

    public static function i(tag:String, message:Object):void
    {
        if (Config.sharedInstance().logLevel <= INFO)
        {
            log(INFO, tag, message);
        }
    }

    public static function w(tag:String, message:Object):void
    {
        if (Config.sharedInstance().logLevel <= WARN)
        {
            log(WARN, tag, message);
        }
    }

    public static function e(tag:String, message:Object):void
    {
        if (Config.sharedInstance().logLevel <= ERROR)
        {
            log(ERROR, tag, message);
        }
    }

    //-------------------------------------
    //  Class methods: Internal
    //-------------------------------------

    private static function log(level:uint, tag:String, message:Object):void
    {
        if (LoggerRegistry.logger != null)
        {
            LoggerRegistry.logger.log(new LogEvent(tag, levelToString(level), message));
        }
    }

    private static function levelToString(level:uint):String
    {
        switch (level)
        {
            case DEBUG : return "DEBUG"; break;
            case INFO : return "INFO"; break;
            case WARN : return "WARN"; break;
            case ERROR : return "ERROR"; break;
            default : return "UNKNOWN"; break;
        }
    }
}
}
