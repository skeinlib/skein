/**
 * Created by max.rozdobudko@gmail.com on 9/29/17.
 */
package skein.rest.errors {
public class UnknownServerError extends Error {
    public function UnknownServerError(message:* = "", id:* = 0) {
        super(message, id);
    }
}
}
