/**
 * Created by Max Rozdobudko on 10/20/15.
 */
package skein.logger
{
public class LogEvent
{
    public function LogEvent(tag:String, level:String, message:Object)
    {
        super();

        _tag = tag;
        _level = level;
        _message = message;
    }

    private var _tag:String;
    public function get tag():String
    {
        return _tag;
    }

    private var _level:String;
    public function get level():String
    {
        return _level;
    }

    private var _message:Object;
    public function get message():Object
    {
        return _message;
    }
}
}
