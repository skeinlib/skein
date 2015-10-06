/**
 * Created by Max Rozdobudko on 10/2/15.
 */
package skein.rest.cache.impl
{
import flash.filesystem.File;
import flash.net.URLRequestHeader;

import skein.rest.cache.CacheStorage;
import skein.rest.cache.headers.Headers;
import skein.rest.utils.DateUtil;
import skein.rest.utils.sha1;

public class FileSystemCacheStorage implements CacheStorage
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    private static const RESERVED_SYMBOLS_PATTERN:RegExp = /[\/\\?*%:|"<>. ]/g;

    private static const CACHE_PROPERTIES_FILE:String = "cache.properties";

    private static const CACHE_DIRECTORY_PATH:String = "skein/cache";

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function FileSystemCacheStorage()
    {
        super();

        if (File.cacheDirectory != null)
        {
            directory = File.cacheDirectory.resolvePath(CACHE_DIRECTORY_PATH);
        }
        else
        {
            directory = File.applicationStorageDirectory.resolvePath(CACHE_DIRECTORY_PATH);
        }

        FileSystemCacheStorageHelper.read(directory.resolvePath(CACHE_PROPERTIES_FILE),
            function(value:* = undefined):void
            {
                if (value == undefined || value is Error)
                {
                    properties = {}
                }
                else
                {
                    properties = value;
                }
            });
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    private var directory:File;

    private var properties:Object;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Methods: Public API
    //-------------------------------------

    public function head(url:String):Headers
    {
        if (properties != null)
        {
            var key:String = normalizeURL(url);

            return properties[key];
        }

        return null;
    }

    public function find(url:String, callback:Function):void
    {
        if (properties != null && directory != null)
        {
            var key:String = normalizeURL(url);

            var o:Object = properties[key];

            FileSystemCacheStorageHelper.read(directory.resolvePath(key), function(value:* = undefined):void
            {
                if (value == undefined || value is Error)
                {
                    callback(null);
                }
                else
                {
                    o.data = value;

                    callback(o);
                }
            });
        }
        else
        {
            callback(null);
        }
    }

    public function keep(url:String, data:Object, headers:Headers):Boolean
    {
        if (properties != null && directory != null)
        {
            var key:String = normalizeURL(url);

            properties[key] = headers;

            FileSystemCacheStorageHelper.save(directory.resolvePath(key), data);

            updateProperties();

            return true;
        }

        return false;
    }

    //-------------------------------------
    //  Methods: Cache Directory
    //-------------------------------------

    //-------------------------------------
    //  Methods: Cache Properties
    //-------------------------------------

    private function updateProperties():void
    {
        if (properties != null)
        {
            FileSystemCacheStorageHelper.save(directory.resolvePath(CACHE_PROPERTIES_FILE), properties);
        }
        else
        {
            try
            {
                directory.resolvePath(CACHE_PROPERTIES_FILE).deleteFile();
            }
            catch (error:Error)
            {

            }
        }
    }

    //-------------------------------------
    //  Methods: Public Internal
    //-------------------------------------

    private function normalizeURL(url:String):String
    {
        return sha1(url);

        return url.replace(RESERVED_SYMBOLS_PATTERN, "_");
    }
}
}
