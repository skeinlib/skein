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
import skein.rest.client.RestClient;
import skein.rest.client.impl.DefaultRestClient;

use namespace skein_internal;

public class Config extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Class functions
    //
    //--------------------------------------------------------------------------

    private static var _rest:String;

    skein_internal static function rest(value:String):void
    {
        _rest = value;
    }

    private static var _auth:String;

    skein_internal static function auth(value:String):void
    {
        _auth = value;
    }

    private static var _implementations:Dictionary = new Dictionary();
    {
        _implementations[RestClient] = DefaultRestClient;
    }

    skein_internal static function setImplementation(contract:Class, implementation:Class):void
    {
        _implementations[contract] = implementation;
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

    public function get rest():String
    {
        return _rest;
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
