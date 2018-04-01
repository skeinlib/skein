/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/17/13
 * Time: 7:55 PM
 * To change this template use File | Settings | File Templates.
 */
package skein
{
import skein.rest.builder.ConfigBuilder;

public class Rest
{
    public static function config(key: String = null):ConfigBuilder {
        return new ConfigBuilder(key);
    }
}
}
