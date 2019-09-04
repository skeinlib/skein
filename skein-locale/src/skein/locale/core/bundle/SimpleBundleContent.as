/**
 * Created by max.rozdobudko@gmail.com on 2019-09-04.
 */
package skein.locale.core.bundle {
import skein.locale.core.BundleContent;
import skein.locale.core.BundleMergeStrategy;

public class SimpleBundleContent implements BundleContent {

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function SimpleBundleContent(): void {
        super();
        _content = {};
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    protected var _content: Object;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function hasResource(name: String): Boolean {
        return name in _content;
    }

    public function setResource(name: String, value: *): void {
        _content[name] = value;
    }

    public function getResource(name: String): * {
        return _content[name];
    }

    public function merge(that: BundleContent, mergeStrategy: BundleMergeStrategy): Boolean {
        for each (var resource: BundleContentEntry in that.getResources()) {
            if (this.hasResource(resource.name) && mergeStrategy == BundleMergeStrategy.keepExistingOne) {
                continue;
            }
            setResource(resource.name, resource.value);
        }
        return true;
    }

    public function getResources(): Vector.<BundleContentEntry> {
        var result: Vector.<BundleContentEntry> = new <BundleContentEntry>[];

        for (var name: String in _content) {
            result.push(new BundleContentEntry(name, _content[name]));
        }

        return result;
    }

}
}
