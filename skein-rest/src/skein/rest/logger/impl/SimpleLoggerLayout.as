/**
 * Created by Max Rozdobudko on 10/21/15.
 */
package skein.rest.logger.impl
{
import skein.rest.logger.LogEvent;
import skein.rest.logger.LoggerLayout;

public class SimpleLoggerLayout implements LoggerLayout
{
    public function SimpleLoggerLayout()
    {
    }

    public function format(event:LogEvent):Object
    {
        return "[" + event.tag + "] " + event.level + ": " + event.message;
    }
}
}
