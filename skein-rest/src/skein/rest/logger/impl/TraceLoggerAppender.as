/**
 * Created by Max Rozdobudko on 10/20/15.
 */
package skein.rest.logger.impl
{
import skein.rest.logger.LogEvent;
import skein.rest.logger.LoggerAppender;
import skein.rest.logger.LoggerLayout;

public class TraceLoggerAppender implements LoggerAppender
{
    public function TraceLoggerAppender(layout:LoggerLayout)
    {
        super();

        _layout = layout;
    }

    private var _layout:LoggerLayout;

    public function get layout():LoggerLayout
    {
        return _layout;
    }

    public function append(event:LogEvent):void
    {
        trace(_layout.format(event));
    }
}
}
