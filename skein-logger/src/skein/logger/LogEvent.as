/**
 * Created by Max Rozdobudko on 10/20/15.
 */
package skein.logger
{
public class LogEvent {

    public function LogEvent(tag: String, level: int, message: Object) {
        super();

        _tag = tag;
        _level = level;
        _message = message;
    }

    private var _tag:String;
    public function get tag():String {
        return _tag;
    }

    private var _level: int;
    public function get level(): int {
        return _level;
    }
    public function get levelForDisplay(): String {
        switch (_level) {
            case Log.DEBUG : return "DEBUG"; break;
            case Log.INFO  : return "INFO"; break;
            case Log.WARN  : return "WARN"; break;
            case Log.ERROR : return "ERROR"; break;
            default : return "UNKNOWN"; break;
        }
    }

    private var _message:Object;
    public function get message():Object {
        return _message;
    }
}
}
