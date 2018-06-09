/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 12/27/13
 * Time: 9:56 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes.builder
{
import skein.core.skein_internal;
import skein.tubes.tube.Tube;
import skein.tubes.tube.media.Broadcast;
import skein.tubes.tube.media.Playback;
import skein.tubes.core.TubeRegistry;
import skein.tubes.tube.media.settings.MediaSettings;

use namespace skein_internal;

public class TubeBuilder {

    // Constructor

    public function TubeBuilder(name: String) {
        super();
        _tube = TubeRegistry.get(name);
    }

    // Tube

    private var _tube:Tube;

    // Builders

    public function connection(): ConnectionBuilder {
        return new ConnectionBuilder(this, _tube);
    }

    public function specifier(): GroupSpecifierBuilder {
        return new GroupSpecifierBuilder(this, _tube);
    }

    public function get media(): MediaBuilder {
        return new MediaBuilder(this, _tube);
    }

    // Builder

    public function build(): Tube {
        return _tube;
    }
}
}
