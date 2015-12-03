/**
 * Created by Max Rozdobudko on 10/2/15.
 */
package skein.rest.cache.impl
{
import flash.utils.getDefinitionByName;

import skein.rest.cache.CacheStorage;
import skein.rest.cache.response.BodyFormat;
import skein.rest.cache.response.Head;
import skein.rest.cache.response.Response;
import skein.rest.utils.sha1;

public class FileSystemCacheStorage implements CacheStorage
{
    //--------------------------------------------------------------------------
    //
    //  AIR classes references
    //
    //--------------------------------------------------------------------------

    protected static const File:Class = getDefinitionByName("flash.filesystem::File") as Class;

    protected static const FileMode:Class = getDefinitionByName("flash.filesystem::FileMode") as Class;

    protected static const FileStream:Class = getDefinitionByName("flash.filesystem::FileStream") as Class;

    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    private static const RESERVED_SYMBOLS_PATTERN:RegExp = /[\/\\?*%:|"<>. ]/g;

    private static const CACHE_PROPERTIES_FILE:String = "cache.properties";

    private static const CACHE_DIRECTORY_PATH:String = "skein.rest.cache";

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function FileSystemCacheStorage()
    {
        super();

        if (directory != null)
        {
            FileSystemCacheStorageHelper.readObject(directory.resolvePath(CACHE_PROPERTIES_FILE),
                function(value:* = undefined):void
                {
                    if (value == undefined || value is Error)
                    {
                        _properties = {}
                    }
                    else
                    {
                        _properties = value;
                    }
                });
        }
        else
        {
            _properties = {};
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  directory
    //-------------------------------------

    private var _directory:Object;

    public function get directory():Object
    {
        if (_directory == null)
        {
            if (File.cacheDirectory != null)
            {
                _directory = File.cacheDirectory.resolvePath(CACHE_DIRECTORY_PATH);
            }
            else
            {
                _directory = File.applicationStorageDirectory.resolvePath(CACHE_DIRECTORY_PATH);
            }
        }

        return _directory;
    }

    //-------------------------------------
    //  directory
    //-------------------------------------

    private var _properties:Object;

    public function get properties():Object
    {
        return _properties;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Methods: Public API
    //-------------------------------------

    public function head(url:String):Head
    {
        if (_properties != null && _directory != null)
        {
            var key:String = keyFromURL(url);

            var head:Head = _properties[key];

            if (head != null)
            {
                if (head.link != null)
                {
                    if (isRelativeURL(head.link))
                    {
                        try
                        {
                            head.link = _directory.resolvePath(head.link).url;
                        }
                        catch (error:Error) { /* ignore error */ }
                    }
                }
                else
                {
                    try
                    {
                        head.link = _directory.resolvePath(key).url;
                    }
                    catch (error:Error) { /* ignore error */ }
                }

                return head;
            }
        }

        return null;
    }

    public function find(url:String, callback:Function):void
    {
        if (_properties != null && _directory != null)
        {
            var key:String = keyFromURL(url);

            var head:Head = _properties[key];

            if (head != null)
            {
                if (isRelativeURL(head.link))
                {
                    try
                    {
                        head.link = _directory.resolvePath(head.link).url;
                    }
                    catch (error:Error) { /* ignore error */ }
                }

                var resultOrErrorCallback:Function = function(value:*=undefined):void
                {
                    if (value == undefined || value is Error)
                    {
                        if (callback != null)
                            callback(null);
                    }
                    else
                    {
                        if (callback != null)
                            callback(new Response(head, value));
                    }
                };

                switch (head.format)
                {
                    case BodyFormat.BINARY :

                        FileSystemCacheStorageHelper.readBytes(_directory.resolvePath(key), resultOrErrorCallback);

                        break;

                    case BodyFormat.OBJECT :
                    default :

                        FileSystemCacheStorageHelper.readObject(_directory.resolvePath(key), resultOrErrorCallback);

                        break;
                }
            }
            else
            {
                if (callback != null)
                    callback(null);
            }
        }
        else
        {
            if (callback != null)
                callback(null);
        }
    }

    public function keep(url:String, response:Response, callback:Function = null):Boolean
    {
        if (_properties != null && _directory != null)
        {
            var key:String = keyFromURL(url);

            try
            {
                response.head.link = key;
            }
            catch (error:Error)
            {
                // ignore error
            }

            _properties[key] = response.head;

            updateProperties();

            var resultOrErrorCallback:Function = function(value:*=undefined):void
            {
                if (value == undefined || value is Error)
                {
                    if (callback != null)
                        callback(null);
                }
                else
                {
                    if (callback != null)
                        callback(response);
                }
            };

            FileSystemCacheStorageHelper.save(_directory.resolvePath(key), response.body, resultOrErrorCallback);

            return true;
        }

        return false;
    }

    public function drop(url:String):void
    {
        if (_properties != null && _directory != null)
        {
            var key:String = keyFromURL(url);

            var file:Object = _directory.resolvePath(key);

            try
            {
                file.deleteFileAsync();
            }
            catch (error:Error)
            {
                // ignore
            }

            _properties[key] = null;
            delete _properties[key];

            updateProperties();
        }
    }

    public function purge():void
    {
        _properties = {};

        removeDirectory();
    }

    //-------------------------------------
    //  Methods: Cache Directory
    //-------------------------------------

    private function removeDirectory():void
    {
        if (_directory != null)
        {
            try
            {
                _directory.deleteDirectory(true);
            }
            catch (error:Error)
            {
                // ignore error
            }
        }
    }

    //-------------------------------------
    //  Methods: Cache Properties
    //-------------------------------------

    private function updateProperties():void
    {
        if (_properties != null)
        {
            FileSystemCacheStorageHelper.save(_directory.resolvePath(CACHE_PROPERTIES_FILE), _properties);
        }
        else
        {
            try
            {
                _directory.resolvePath(CACHE_PROPERTIES_FILE).deleteFile();
            }
            catch (error:Error)
            {

            }
        }
    }

    //-------------------------------------
    //  Methods: Internal
    //-------------------------------------

    private function keyFromURL(url:String):String
    {
        return url != null ? sha1(url) : null;
    }

    private function isRelativeURL(url:String):Boolean
    {
        return url && url.indexOf("://") == -1;
    }
}
}
