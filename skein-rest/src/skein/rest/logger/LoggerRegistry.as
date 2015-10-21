/**
 * Created by Max Rozdobudko on 10/20/15.
 */
package skein.rest.logger
{
import skein.core.skein_internal;
import skein.rest.core.Config;

use namespace skein_internal;

public class LoggerRegistry
{
    private static var _logger:Logger;

    public static function get logger():Logger
    {
        if (_logger == null)
        {
            var Implementation:Class = Config.sharedInstance().getImplementation(Logger);

            if (Implementation != null)
            {
                _logger = new Implementation();
                _logger.appenders = Config.sharedInstance().releaseLoggerAppenders();
            }
        }

        return _logger;
    }
}
}
