/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/29/13
 * Time: 10:28 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.locale.core
{
public class RawData
{
    public function RawData(locale:String, bundle:String, content:Object)
    {
        super();

        _locale = locale;
        _bundle = bundle;
        _content = content;
    }

    private var _locale:String;

    public function get locale():String
    {
        return _locale;
    }

    private var _bundle:String;

    public function get bundle():String
    {
        return _bundle;
    }

    private var _content:Object;

    public function get content():Object
    {
        return _content;
    }
}
}
