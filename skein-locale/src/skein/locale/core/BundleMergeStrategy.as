/**
 * Created by max.rozdobudko@gmail.com on 2019-06-13.
 */
package skein.locale.core {
public class BundleMergeStrategy {

    public static const keepExistingOne: BundleMergeStrategy = new BundleMergeStrategy("keepExistingOne");
    public static const replaceWithNew: BundleMergeStrategy = new BundleMergeStrategy("replaceWithNew");

    public function BundleMergeStrategy(id: String) {
        super();
        this._id = id;
    }

    private var _id: String;
    public function get id(): String {
        return _id;
    }
}
}
