/**
 * Created by Max Rozdobudko on 10/2/15.
 */
package skein.rest.cache.impl
{
import flash.filesystem.File;
import flash.net.SharedObject;

import skein.rest.cache.CacheStorage;

public class FileSystemCacheStorage implements CacheStorage
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    private static const RESERVED_SYMBOLS_PATTERN:RegExp = /[\/\\?*%:|"<>. ]/g;

    private static const CACHE_PROPERTIES:String = "cache.properties";

    private static const CACHE_DIRECTORY_PATH:String = "/skein/cache";

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function FileSystemCacheStorage()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    private var directory:File;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Methods: Public API
    //-------------------------------------

    private var initialized:Boolean = false;

    public function init():void
    {
        FileSystemCacheStorageHelper.readProperties(directory.resolvePath(CACHE_PROPERTIES),
            function(value:Object = null, error:Error = null):void
            {



            });
    }

    public function live(url:String):Boolean
    {
        if (initialized)
        {
            var normalURL:String = normalizeURL(url);

            if (directory.resolvePath(normalURL))
            {

            }
        }

        if (directory != null)
        {
            if (directory.exists)
            {
                var stream
            }
        }

        return false;
    }

    public function find(url:String):Object
    {
        return null;
    }

    public function keep(url:String, data:Object, headers:Array):Boolean
    {


        return false;
    }

    //-------------------------------------
    //  Methods: Cache Directory
    //-------------------------------------

    private function createDirectory():void
    {
        if (directory == null)
        {
            if (File.cacheDirectory != null)
            {
                directory = File.cacheDirectory.resolvePath(CACHE_DIRECTORY_PATH);
            }
            else
            {
                directory = File.applicationStorageDirectory.resolvePath(CACHE_DIRECTORY_PATH);
            }

            try
            {
                directory.createDirectory();
            }
            catch (error:Error)
            {

            }
        }
    }

    private function deleteDirectory():void
    {
        if (directory != null)
        {
            try
            {
                directory.deleteDirectory(true);
            }
            catch (error:Error)
            {

            }
        }
    }

    //-------------------------------------
    //  Methods: Cache Properties
    //-------------------------------------

    private function updateCacheProperties():void
    {

    }

    //-------------------------------------
    //  Methods: Public Internal
    //-------------------------------------

    private function normalizeURL(url:String):String
    {
        return url.replace(RESERVED_SYMBOLS_PATTERN, "_");
    }
}
}
