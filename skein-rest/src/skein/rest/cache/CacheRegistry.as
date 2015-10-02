/**
 * Created by Max Rozdobudko on 10/2/15.
 */
package skein.rest.cache
{
import skein.rest.core.Config;

public class CacheRegistry
{
    private static var _storage:CacheStorage;

    public static function storage():CacheStorage
    {
        if (_storage == null)
        {
            var Implementation:Class = Config.sharedInstance().getImplementation(CacheStorage);

            if (Implementation != null)
            {
                _storage = new Implementation();
            }
        }

        return _storage;
    }
}
}
