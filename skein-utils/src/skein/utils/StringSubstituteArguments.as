/**
 * Created by max.rozdobudko@gmail.com on 11/17/17.
 */
package skein.utils {
public class StringSubstituteArguments {

    public function StringSubstituteArguments(value: Array) {
        super();
        _value = value;
    }

    private var _value: Array;
    public function get value(): Array {
        return _value;
    }
}
}
