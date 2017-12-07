/**
 * Created by Max Rozdobudko on 10/21/15.
 */
package skein.logger
{
public interface LoggerLayout
{
    function format(event:LogEvent):Object;
}
}
