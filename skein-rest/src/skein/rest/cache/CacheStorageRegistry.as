/**
 * Created by Max Rozdobudko on 10/2/15.
 */
package skein.rest.cache
{
import flash.net.registerClassAlias;

import skein.rest.cache.response.CacheControl;
import skein.rest.cache.response.ETag;
import skein.rest.cache.response.Expires;
import skein.rest.cache.response.Headers;
import skein.rest.core.Config;

public class CacheStorageRegistry
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

    {
        registerClassAlias("skein.rest.cache.response.Headers", Headers);
        registerClassAlias("skein.rest.cache.response.ETag", ETag);
        registerClassAlias("skein.rest.cache.response.Expires", Expires);
        registerClassAlias("skein.rest.cache.response.CacheControl", CacheControl);
    }
}
}
