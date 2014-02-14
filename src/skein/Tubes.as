/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 12/26/13
 * Time: 2:14 PM
 * To change this template use File | Settings | File Templates.
 */
package skein
{
import skein.tubes.builder.ConfigBuilder;
import skein.tubes.builder.TubeBuilder;

public class Tubes
{
    public static function config():ConfigBuilder
    {
        return new ConfigBuilder();
    }

    public static function tube(name:String):TubeBuilder
    {
        return new TubeBuilder(name);
    }
}
}
