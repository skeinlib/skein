/**
 * Created by max.rozdobudko@gmail.com on 9/1/17.
 */
package skein.validators.events {
import flash.events.Event;

public class ValidatorGroupEvent extends Event {

    public static const VALIDATION_CHANGE: String = "validationChange";

    public function ValidatorGroupEvent(type: String, isValid: Boolean, bubbles: Boolean = false, cancelable: Boolean = false) {
        super(type, bubbles, cancelable);
        _isValid = isValid;
    }

    private var _isValid: Boolean;
    public function get isValid(): Boolean {
        return _isValid;
    }
}
}
