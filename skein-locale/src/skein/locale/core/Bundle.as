/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/26/13
 * Time: 2:47 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.locale.core
{
import skein.core.skein_internal;

use namespace skein_internal;

public class Bundle
{
    public function Bundle(locale:String, name:String, content:Object)
    {
        super();

        _name = name;
        _locale = locale;
        _content = content;
    }

    private var _name:String;
    public function get name():String
    {
        return _name;
    }

    private var _locale:String;
    public function get locale():String
    {
        return _locale;
    }

    private var _content:Object;
    public function get content():Object
    {
        return _content;
    }

    skein_internal function merge(bundle: Bundle, mergeStrategy: BundleMergeStrategy): Boolean {
        if (bundle.locale != locale || bundle.name != name) {
            return false;
        }

        for (var property: String in bundle.content) {
            if (content.hasOwnProperty(property) && mergeStrategy == BundleMergeStrategy.keepExistingOne) {
                continue;
            }
            content[property] = bundle.content[property];
        }

        return true;
    }
}
}
