/**
 * Created by max.rozdobudko@gmail.com on 6/9/18.
 */
package skein.tubes.builder {
import skein.core.skein_internal;
import skein.tubes.tube.Tube;

use namespace skein_internal;

public class MediaBuilder {

    // Constructor

    public function MediaBuilder(parent: TubeBuilder, tube: Tube) {
        super();
        _parent = parent;
        _tube = tube;
    }

    // Variables

    private var _parent: TubeBuilder;

    private var _tube: Tube;

    // Builders

    public function settings(): MediaSettingsBuilder {
        return new MediaSettingsBuilder(this, _tube);
    }

    // Builder

    public function build(): TubeBuilder {
        return _parent;
    }
}
}
