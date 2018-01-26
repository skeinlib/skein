/**
 * Created by Max Rozdobudko on 10/21/15.
 */
package skein.logger.impl
{
import skein.logger.LogEvent;
import skein.logger.LoggerLayout;

public class SimpleLoggerLayout implements LoggerLayout
{
    public function SimpleLoggerLayout()
    {
    }

    public function format(event:LogEvent):Object
    {
        return "[" + event.tag + "] " + event.levelForDisplay + ": " + event.message;
    }
}
}
