/**
 * Created by Max Rozdobudko on 10/20/15.
 */
package skein.rest.logger
{
public interface LoggerAppender
{
    function get layout():LoggerLayout;

    function append(event:LogEvent):void;
}
}
