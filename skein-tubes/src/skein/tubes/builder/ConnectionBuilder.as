/**
 * Created by max.rozdobudko@gmail.com on 6/9/18.
 */
package skein.tubes.builder {
import skein.core.skein_internal;
import skein.tubes.tube.Tube;

use namespace skein_internal;

public class ConnectionBuilder {

    // Constructor

    public function ConnectionBuilder(parent: TubeBuilder, tube: Tube) {
        super();
        _parent = parent;
        _tube = tube;
    }

    // Variables

    private var _parent: TubeBuilder;

    private var _tube: Tube;

    // Builder

    private var _address: String;
    public function address(value: String): ConnectionBuilder {
        _address = value;
        return this;
    }

    public function build(): TubeBuilder {
        _tube.connector.setAddress(_address);
        return _parent;

    }
}
}
