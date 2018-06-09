/**
 * Created by max.rozdobudko@gmail.com on 6/9/18.
 */
package skein.tubes.builder {
import skein.core.skein_internal;
import skein.tubes.tube.Tube;
import skein.tubes.tube.media.settings.MediaSettings;

use namespace skein_internal;

public class MediaSettingsBuilder {

    // Constructor

    public function MediaSettingsBuilder(parent: MediaBuilder, tube: Tube) {
        super();
        _parent = parent;
        _tube = tube;
    }

    // Variables

    private var _parent: MediaBuilder;

    private var _tube: Tube;

    private var _settings: MediaSettings;

    // Builder

    public function overrideMediaSettingsWith(settings: MediaSettings): MediaSettingsBuilder {
        _settings = settings;
        return this;
    }

    public function build(): MediaBuilder {
        if (_settings) {
            _tube.setSettings(_settings);
        }
        return _parent;
    }
}
}
