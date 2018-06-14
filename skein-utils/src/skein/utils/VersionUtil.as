/**
 * Created by max.rozdobudko@gmail.com on 6/14/18.
 */
package skein.utils {
public class VersionUtil {

    public static function isVersionString(string: String): Boolean {
        var pattern: RegExp = /^((\d)+(\.{0,1}(\d))*)+$/g;
        return pattern.test(string);
    }

    public static function compare(lhs: String, rhs: String): int {
        if (!isVersionString(lhs) || !isVersionString(rhs)) {
            return 0;
        }

        var lhsNumbers: Array = lhs.split(".").map(function(chars: String, ...rest): int {return parseInt(chars)}).filter(function(number: Number, ...rest): Boolean { return !isNaN(number)});
        var rhsNumbers: Array = rhs.split(".").map(function(chars: String, ...rest): int {return parseInt(chars)}).filter(function(number: Number, ...rest): Boolean { return !isNaN(number)});

        for (var i: int = 0, n:int = Math.max(lhsNumbers.length, rhsNumbers.length); i < n; i++) {
            var lhsNumber: int = lhsNumbers.length <= i ? 0 : int(lhsNumbers[i]);
            var rhsNumber: int = rhsNumbers.length <= i ? 0 : int(rhsNumbers[i]);

            if (lhsNumber < rhsNumber) {
                return -1;
            }
            if (lhsNumber > rhsNumber) {
                return +1;
            }
        }

        return 0;
    }

    public static function isGreaterThan(version: String, versionToCompare: String): Boolean {
        return compare(version, versionToCompare) > 0;
    }

    public static function isEqual(version: String, versionToCompare: String): Boolean {
        return compare(version, versionToCompare) == 0;
    }

    public static function isLessThan(version: String, versionToCompare: String): Boolean {
        return compare(version, versionToCompare) < 0;
    }

}
}
