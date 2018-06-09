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
import skein.tubes.tube.media.settings.MediaSettings;

use namespace skein_internal

public class ConfigBuilder {

    // Constructor

    public function ConfigBuilder() {
        super()
    }

    // Builders

    public function replication(): ConfigReplicationBuilder {
        return new ConfigReplicationBuilder(this);
    }

    // Builder

    public function address(value: String): ConfigBuilder {
        PropertySetter.set(Config.shared, "address", value);
        return this;
    }

    public function settings(value: MediaSettings): ConfigBuilder {
        PropertySetter.set(Config.shared, "settings", value);
        return this;
    }

    public function build(): void {
    }
}
}
