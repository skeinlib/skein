/**
 * Created by Max Rozdobudko on 10/20/15.
 */
package skein.logger.impl
{
import skein.logger.LogEvent;
import skein.logger.LoggerAppender;
import skein.logger.LoggerLayout;

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
