/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/17/13
 * Time: 7:01 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.core
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.Dictionary;

import skein.core.skein_internal;

import skein.core.skein_internal;
import skein.rest.cache.CacheClient;
import skein.rest.cache.impl.DefaultCacheClient;
import skein.rest.client.RestClient;
import skein.rest.client.impl.DefaultRestClient;
import skein.rest.logger.Logger;
import skein.rest.logger.LoggerAppender;
import skein.rest.logger.impl.DefaultLogger;
import skein.rest.logger.impl.SimpleLoggerLayout;
import skein.rest.logger.impl.TraceLoggerAppender;

use namespace skein_internal;

public class Config extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Class functions
    //
    //--------------------------------------------------------------------------

    private static var _auth:String;

    skein_internal static function auth(value:String):void
    {
        _auth = value;
    }

    private static var _implementations:Dictionary = new Dictionary();
    {
        _implementations[RestClient] = DefaultRestClient;
        _implementations[CacheClient] = DefaultCacheClient;
        _implementations[Logger] = DefaultLogger;
    }

    skein_internal static function setImplementation(contract:Class, implementation:Class):void
    {
        _implementations[contract] = implementation;
    }

    private static var _errorHook:Function;

    skein_internal static function setErrorHook(hook:Function):void
    {
        _errorHook = hook;
    }

    //--------------------------------------------------------------------------
    //
    //  Shared Instance
    //
    //--------------------------------------------------------------------------

    private static var instance:Config;

    public static function sharedInstance():Config
    {
        if (instance == null)
            instance = new Config();

        return instance;
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Config()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-----------------------------------
    //  auth
    //-----------------------------------

    public function get auth():String
    {
        return _auth;
    }

    //-----------------------------------
    //  rest
    //-----------------------------------

    private var _rest:String;

    public function get rest():String
    {
        return _rest;
    }

    public function set rest(value:String):void
    {
        _rest = value;
    }

    //-----------------------------------
    //  errorHook
    //-----------------------------------

    public function get errorHook():Function
    {
        return _errorHook;
    }

    //-----------------------------------
    //  fixKnownIssue
    //-----------------------------------

    private var _fixKnownIssues:Boolean;

    public function get fixKnownIssues():Boolean
    {
        return _fixKnownIssues;
    }

    skein_internal function setFixKnownIssues(value:Boolean):void
    {
        _fixKnownIssues = value;
    }

    //-----------------------------------
    //  accessToken
    //-----------------------------------

    private var _accessToken:String = null;

    [Bindable(event="accessTokenChanged")]
    public function get accessToken():String
    {
        return _accessToken;
    }

    public function set accessToken(value:String):void
    {
        if (_accessToken == value) return;
        _accessToken = value;
        dispatchEvent(new Event("accessTokenChanged"));
    }

    //-----------------------------------
    //  accessTokenKey
    //-----------------------------------

    private var _accessTokenKey:String = "access_token";

    [Bindable(event="accessTokenKeyChanged")]
    public function get accessTokenKey():String
    {
        return _accessTokenKey;
    }

    public function set accessTokenKey(value:String):void
    {
        if (_accessTokenKey == value) return;
        _accessTokenKey = value;
        dispatchEvent(new Event("accessTokenKeyChanged"));
    }

    //-----------------------------------
    //  useCache
    //-----------------------------------

    private var _useCache:Boolean;

    [Bindable(event="useCacheChanged")]
    public function get useCache():Boolean
    {
        return _useCache;
    }

    public function set useCache(value:Boolean):void
    {
        if (_useCache == value) return;

        _useCache = value;
        _cache = null;

        dispatchEvent(new Event("useCacheChanged"));
    }

    //-----------------------------------
    //  cache
    //-----------------------------------

    private var _cache:CacheClient;

    public function get cache():CacheClient
    {
        if (_cache == null)
        {
            var Impl:Class = getImplementation(CacheClient);

            if (Impl != null)
            {
                _cache = new Impl();

                if (_cache is DefaultCacheClient)
                {
                    DefaultCacheClient(_cache).setIgnoreParams(_cacheIgnoreParams);
                }
            }
        }

        return _cache;
    }

    //-----------------------------------
    //  cacheIgnoreParams
    //-----------------------------------

    private var _cacheIgnoreParams:Array;

    public function get cacheIgnoreParams():Array
    {
        return _cacheIgnoreParams;
    }

    skein_internal function setCacheIgnoreParams(value:Array):void
    {
        _cacheIgnoreParams = value;
    }

    //-----------------------------------
    //  logLevel
    //-----------------------------------

    private var _logLevel:uint = uint.MAX_VALUE;

    public function get logLevel():uint
    {
        return _logLevel;
    }

    public function set logLevel(value:uint):void
    {
        _logLevel = value;
    }

    //-----------------------------------
    //  loggerAppenders
    //-----------------------------------

    private var _loggerAppenders:Vector.<LoggerAppender>;

    skein_internal function releaseLoggerAppenders():Vector.<LoggerAppender>
    {
        var result:Vector.<LoggerAppender> = _loggerAppenders;

        _loggerAppenders = null;

        return result;
    }

    skein_internal function retainLoggerAppenders(value:Vector.<LoggerAppender>):void
    {
        _loggerAppenders = value;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function getImplementation(contract:Class):Class
    {
        return _implementations[contract];
    }
}
}
