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
import skein.rest.cache.CacheClient;
import skein.rest.cache.impl.DefaultCacheClient;
import skein.rest.client.RestClient;
import skein.rest.client.impl.DefaultRestClient;
import skein.utils.Base64;

use namespace skein_internal;

public class Config extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Class functions
    //
    //--------------------------------------------------------------------------

    private static var _auth: String;

    skein_internal static function auth(value: String):void
    {
        _auth = value;
    }

    private static var _implementations:Dictionary = new Dictionary();
    {
        _implementations[RestClient] = DefaultRestClient;
        _implementations[CacheClient] = DefaultCacheClient;
    }

    skein_internal static function setImplementation(contract:Class, implementation:Class):void
    {
        _implementations[contract] = implementation;
    }

    private static var _beforeResultHook: Function;
    skein_internal static function setBeforeResultHook(hook: Function): void {
        _beforeResultHook = hook;
    }

    private static var _afterResultHook: Function;
    public static function setAfterResultHook(hook: Function): void {
        _afterResultHook = hook;
    }

    private static var _errorHook: Function;
    skein_internal static function setErrorHook(hook: Function):void {
        _errorHook = hook;
    }

    private static var _errorDecoder: Function;
    skein_internal static function setErrorDecoder(decoder: Function):void {
        _errorDecoder = decoder;
    }

    private static var _progressHandler: Function;
    skein_internal static function setProgressHandler(value: Function):void {
        _progressHandler = value;
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

    public function get auth(): String {
        return _auth;
    }

    //-----------------------------------
    //  rest
    //-----------------------------------

    private var _rest: String;
    public function get rest(): String {
        return _rest;
    }
    public function set rest(value: String):void {
        _rest = value;
    }

    //-----------------------------------
    //  beforeResultHook
    //-----------------------------------

    public function get beforeResultHook(): Function {
        return _beforeResultHook;
    }

    //-----------------------------------
    //  afterResultHook
    //-----------------------------------

    public function get afterResultHook(): Function {
        return _afterResultHook;
    }

    //-----------------------------------
    //  errorHook
    //-----------------------------------

    public function get errorHook(): Function {
        return _errorHook;
    }

    //-----------------------------------
    //  errorDecoder
    //-----------------------------------

    public function get errorDecoder(): Function {
        return _errorDecoder;
    }

    //-----------------------------------
    //  progressHandler
    //-----------------------------------

    public function get progressHandler(): Function {
        return _progressHandler;
    }

    //-----------------------------------
    //  fixKnownIssue
    //-----------------------------------

    private var _fixKnownIssues:Boolean;
    public function get fixKnownIssues():Boolean {
        return _fixKnownIssues;
    }
    skein_internal function setFixKnownIssues(value:Boolean):void {
        _fixKnownIssues = value;
    }

    //-----------------------------------
    //  accessToken
    //-----------------------------------

    private var _accessToken: String = null;

    [Bindable(event="accessTokenChanged")]
    public function get accessToken(): String
    {
        return _accessToken;
    }

    public function set accessToken(value: String):void
    {
        if (_accessToken == value) return;
        _accessToken = value;
        dispatchEvent(new Event("accessTokenChanged"));
    }

    //-----------------------------------
    //  accessTokenKey
    //-----------------------------------

    private var _accessTokenKey: String = "access_token";

    [Bindable(event="accessTokenKeyChanged")]
    public function get accessTokenKey(): String
    {
        return _accessTokenKey;
    }

    public function set accessTokenKey(value: String):void
    {
        if (_accessTokenKey == value) return;
        _accessTokenKey = value;
        dispatchEvent(new Event("accessTokenKeyChanged"));
    }

    //-----------------------------------
    //  username
    //-----------------------------------

    private var _username: String;
    /** Basic Authorization username */
    public function get username(): String {
        return _username;
    }
    public function set username(value: String):void {
        if (_username == value) return;
        _username = value;
        updateAuthorization()
    }

    //-----------------------------------
    //  password
    //-----------------------------------

    private var _password: String;
    /** Basic Authorization password */
    public function get password(): String {
        return _password;
    }
    public function set password(value: String):void {
        if (_password == value) return;
        _password = value;
        updateAuthorization()
    }

    //-----------------------------------
    //  token
    //-----------------------------------

    private var _token: String;
    /** Bearer Authentication token */
    public function get token(): String {
        return _token;
    }
    public function set token(value: String): void {
        if (value == _token) return;
        _token = value;
        updateAuthorization();
    }

    //-----------------------------------
    //  bearerAuthorization
    //-----------------------------------

    private var _authorization: String;
    public function get authorization(): String {
        return _authorization;
    }

    private function updateAuthorization(): void {
        if (_token) {
            _authorization = "Bearer " + _token;
        } else if (_username && _password) {
            _authorization = "Basic " + Base64.encode(_username + ":" + _password);
        } else {
            _authorization = null;
        }
    }

    //-----------------------------------
    //  useQueue
    //-----------------------------------

    private var _useQueue:Boolean = true;

    [Bindable(event="useQueueChanged")]
    public function get useQueue():Boolean
    {
        return _useQueue;
    }

    public function set useQueue(value:Boolean):void
    {
        if (_useQueue == value) return;
        _useQueue = value;
        dispatchEvent(new Event("useQueueChanged"));
    }

    //-----------------------------------
    //  useCache
    //-----------------------------------

    private var _useCache:Boolean = false;

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
