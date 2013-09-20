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

public class ParserChain
{
    public function ParserChain()
    {
        super();

        this.parsers = new <Parser>
        [
            new BundleParser(),
            new PropertiesParser(),
        ];
    }

    private var parsers:Vector.<Parser>;

    public function parse(data:Object):Vector.<Bundle>
    {
        for (var i:int, n:int = parsers.length; i < n; i++)
        {
            if (parsers[i].known(data))
                return parsers[i].parse(data);
        }

        return null;
    }
}
}
