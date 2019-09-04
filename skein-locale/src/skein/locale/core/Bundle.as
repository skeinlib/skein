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

public class Bundle {

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Bundle(locale: String, name: String, content: BundleContent) {
        super();

        _name = name;
        _locale = locale;
        _content = content;
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  name
    //-------------------------------------

    private var _name: String;
    public function get name(): String {
        return _name;
    }

    //-------------------------------------
    //  locale
    //-------------------------------------

    private var _locale: String;
    public function get locale(): String {
        return _locale;
    }

    //-------------------------------------
    //  content
    //-------------------------------------

    private var _content: BundleContent;
    public function get content(): BundleContent {
        return _content;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    skein_internal function merge(bundle: Bundle, mergeStrategy: BundleMergeStrategy): Boolean {
        if (bundle.locale != locale || bundle.name != name) {
            return false;
        }

        return this.content.merge(bundle.content, mergeStrategy);
    }
}
}
