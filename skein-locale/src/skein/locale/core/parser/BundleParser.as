/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/26/13
 * Time: 4:56 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.locale.core.parser
{
import skein.locale.core.Bundle;
import skein.locale.core.Parser;

public class BundleParser implements Parser
{
    public function BundleParser()
    {
    }

    public function known(data:Object):Boolean
    {
        return data is Bundle || data is Vector.<Bundle>;
    }

    public function parse(data:Object):Vector.<Bundle>
    {
        if (data is Vector.<Bundle>)
            return data as Vector.<Bundle>;
        else
            return new <Bundle>[data as Bundle];
    }
}
}
