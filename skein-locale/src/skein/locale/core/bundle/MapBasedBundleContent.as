/**
 * Created by max.rozdobudko@gmail.com on 2019-09-04.
 */
package skein.locale.core.bundle {
import skein.core.skein_internal;
import skein.locale.core.BundleContent;
import skein.locale.core.BundleMergeStrategy;

use namespace skein_internal;

public class MapBasedBundleContent implements BundleContent {

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function MapBasedBundleContent() {
        super();
        _entries = new Vector.<BundleContentEntry>();
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    protected var _entries: Vector.<BundleContentEntry>;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function getResources(): Vector.<BundleContentEntry> {
        return _entries;
    }

    public function hasResource(name: String): Boolean {
        return _entries.some(function(resource: BundleContentEntry, ...rest): Boolean {
            return resource.name == name;
        });
    }

    public function setResource(name: String, value: *): void {
        var found: Vector.<BundleContentEntry> = _entries.filter(function(resource: BundleContentEntry, ...rest): Boolean {
            if (resource.name == name) {
                return resource;
            }
        });

        if (found.length > 1) {
            trace("[skein-locale] Warning: more than one resource found with name \"" + name + "\".");
        }

        if (found.length > 0) {
            found.forEach(function(resource: BundleContentEntry, ...rest): void {
                resource.setValue(value);
            });
            return
        }

        _entries.push(new BundleContentEntry(name, value));
    }

    public function getResource(name: String): * {
        var found: Vector.<BundleContentEntry> = _entries.filter(function(resource: BundleContentEntry, ...rest): Boolean {
            if (resource.name == name) {
                return resource;
            }
        });

        if (found.length == 0) {
            return null;
        }

        return found[0].value;
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
}
}
