/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/29/13
 * Time: 10:04 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.locale.core.parser
{
import skein.locale.core.Bundle;
import skein.locale.core.BundleContent;
import skein.locale.core.Parser;
import skein.locale.core.RawData;
import skein.utils.StringUtil;

public class PropertiesParser implements Parser {

    private static const PATTERN:RegExp = /[\w\.]+\s*=\s*\.*/;

    public function PropertiesParser() {
        super();
    }

    public function known(data: Object): Boolean
    {
        var result:Boolean =
            data is RawData && PATTERN.test(String(RawData(data).content));

        return result;
    }

    public function parse(data: Object, BundleContentType: Class): Vector.<Bundle> {

        var raw:RawData = data as RawData;

        var src:String = String(RawData(data).content);

        var content: BundleContent = new BundleContentType();

        for each (var line:String in src.split("\n")) {
            var assignmentIndex:int = line.indexOf("=");

            var key:String = StringUtil.trim(line.substring(0, assignmentIndex));
            key = key.split("\\n").join("\n");

            var value: String = line.substring(assignmentIndex + 1);
            value = value.split("\\n").join("\n");

            content.setResource(key, value);
        }

        var bundle:Bundle = new Bundle(raw.locale, raw.bundle, content);

        return new <Bundle>[bundle];
    }
}
}
