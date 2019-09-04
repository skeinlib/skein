/**
 * Created by max.rozdobudko@gmail.com on 2019-09-04.
 */
package skein.locale.core {
import skein.locale.core.bundle.BundleContentEntry;

public interface BundleContent {

    function getResources(): Vector.<BundleContentEntry>;

    function hasResource(name: String): Boolean;

    function setResource(name: String, value: *): void;

    function getResource(name: String): *;

    function merge(that: BundleContent, mergeStrategy: BundleMergeStrategy): Boolean;
}
}
