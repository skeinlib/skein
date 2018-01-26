/**
 * Created by Max Rozdobudko on 10/20/15.
 */
package skein.logger
{
public interface Logger
{
    function get appenders():Vector.<LoggerAppender>;
    function set appenders(value:Vector.<LoggerAppender>):void;

    function log(event:LogEvent):void;
}
}
