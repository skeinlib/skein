/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 11:16 AM
 * To change this template use File | Settings | File Templates.
 */
package skein
{
import skein.components.builder.BuilderFactory;
import skein.impl.feathers.componenets.builder.FeathersBuilderFactory;

public class Components
{
    private static var factory:BuilderFactory;

    public static function setFactory(value:BuilderFactory):void
    {
        factory = value;
    }

    public static function host(host:Object):BuilderFactory
    {
        return new FeathersBuilderFactory(host);
    }
}
}
