/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 1/3/14
 * Time: 10:30 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes.builder
{
import skein.core.skein_internal;
import skein.tubes.core.Config;

use namespace skein_internal;

public class ConfigReplicationBuilder
{
    public function ConfigReplicationBuilder(parent:ConfigBuilder)
    {
        super();

        this.parent = parent;
    }

    private var parent:ConfigBuilder;

    public function setWriterFor(type:Class, factory:Object):ConfigReplicationBuilder
    {
        Config.setWriter(type, factory);

        return this;
    }

    public function setReaderFor(type:Class, factory:Object):ConfigReplicationBuilder
    {
        Config.setReader(type, factory);

        return this;
    }

    public function build():ConfigBuilder
    {
        return parent;
    }
}
}
