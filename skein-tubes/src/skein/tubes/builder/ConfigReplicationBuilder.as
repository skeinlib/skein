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

public class ConfigReplicationBuilder {

    // Constructor

    public function ConfigReplicationBuilder(parent:ConfigBuilder) {
        super();
        _parent = parent;
    }

    // Variables

    private var _parent:ConfigBuilder;

    // Builder

    public function setWriterFor(Contract: Class, factory: Object): ConfigReplicationBuilder {
        Config.setWriter(Contract, factory);
        return this;
    }

    public function setReaderFor(Contract: Class, factory: Object): ConfigReplicationBuilder {
        Config.setReader(Contract, factory);
        return this;
    }

    public function build(): ConfigBuilder {
        return _parent;
    }
}
}
