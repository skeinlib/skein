/**
 * Created by Max Rozdobudko on 10/20/15.
 */
package skein.logger.core
{
import skein.core.skein_internal;
import skein.logger.*;

use namespace skein_internal;

public class LoggerRegistry {

    private static const _loggers: Object = {};

    public static function getLogger(tag: String): Logger {
        if (_loggers.hasOwnProperty(tag)) {
            return _loggers[tag];
        } else {
            var Implementation:Class = Config.getImplementationForTag(tag, Logger);
            if (Implementation != null) {
                var logger: Logger = new Implementation();
                logger.appenders = Config.releaseLoggerAppenders(tag);
                _loggers[tag] = logger;
                return logger;
            }
        }
        return null;
    }
}
}
