/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/26/13
 * Time: 3:44 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.locale.core
{
import skein.locale.core.parser.BundleParser;
import skein.locale.core.parser.PropertiesParser;

public class ParserChain {

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function ParserChain() {
        super();

        this.parsers = new <Parser>[
            new BundleParser(),
            new PropertiesParser(),
        ];
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var parsers:Vector.<Parser>;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function parse(data: Object, BundleContentType: Class): Vector.<Bundle> {

        for (var i:int, n:int = parsers.length; i < n; i++) {
            if (parsers[i].known(data)) {
                return parsers[i].parse(data, BundleContentType);
            }
        }

        return null;
    }
}
}
