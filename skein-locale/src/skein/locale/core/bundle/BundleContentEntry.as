/**
 * Created by max.rozdobudko@gmail.com on 2019-09-04.
 */
package skein.locale.core.bundle {
import skein.core.skein_internal;

public class BundleContentEntry {

    public function BundleContentEntry(name: String, value: *) {
        _name = name;
        _value = value;
    }

    private var _name: String;
    public function get name(): String {
        return _name;
    }

    private var _value: *;
    public function get value(): * {
        return _value;
    }
    skein_internal function setValue(value: *): void {
        _value = value;
    }
}
}
