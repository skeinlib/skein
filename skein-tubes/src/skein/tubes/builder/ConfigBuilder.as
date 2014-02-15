/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 12/26/13
 * Time: 5:12 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes.builder
{
import skein.core.PropertySetter;
import skein.core.skein_internal;
import skein.tubes.core.Config;

use namespace skein_internal

public class ConfigBuilder
{
    public function ConfigBuilder()
    {
        super()
    }

    public function server(value:String):ConfigBuilder
    {
        Config.server(value);

        return this;
    }

    public function settings(value:Object):ConfigBuilder
    {
        PropertySetter.set(Config.sharedInstance(), "settings", value);

        return this;
    }

    public function replication():ConfigReplicationBuilder
    {
        return new ConfigReplicationBuilder(this);
    }


    public function configure():ConfigBuilder
    {
        return this;
    }
}
}
