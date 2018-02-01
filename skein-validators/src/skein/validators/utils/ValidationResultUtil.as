/**
 * Created by max.rozdobudko@gmail.com on 2/1/18.
 */
package skein.validators.utils {
import skein.utils.ArrayUtil;
import skein.validators.data.ValidationResult;

public class ValidationResultUtil {

    public static function same(results1: Array, results2: Array): Boolean {
        return ArrayUtil.same(results1, results2, function (result1: ValidationResult, result2: ValidationResult): Boolean {
            return result1.equals(result2);
        });
    }
}
}
