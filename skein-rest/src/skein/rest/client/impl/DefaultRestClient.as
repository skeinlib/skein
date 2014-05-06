/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/17/13
 * Time: 6:57 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client.impl
{
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.net.URLRequestHeader;
import flash.net.URLRequestMethod;
import flash.net.URLStream;
import flash.net.URLVariables;

import mx.utils.StringUtil;

import skein.core.skein_internal;

import skein.rest.core.Config;
import skein.rest.core.Decoder;
import skein.rest.core.Encoder;
import skein.rest.client.RestClient;
import skein.rest.core.HeaderHandler;
import skein.rest.core.RestClientRegistry;

use namespace skein_internal;

public class DefaultRestClient implements RestClient
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function DefaultRestClient()
    {
        super();

        trace("DefaultRestClient");
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var _url:String;

    private var loader:URLLoader;

    private var request:URLRequest;

    //

    private var removeDefaultHeaders:Boolean = false;

    //--------------------------------------------------------------------------
    //
    //  Initialize Methods
    //
    //--------------------------------------------------------------------------

    public function init(api:String, params:Array):void
    {
        if (api.indexOf("http") == 0)
        {
            _url = StringUtil.substitute(api, params);
        }
        else
        {
            _url = Config.sharedInstance().rest + StringUtil.substitute(api, params);
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  headers
    //------------------------------------

    private var _headers:Array;

    public function addHeader(value:Object):RestClient
    {
        _headers ||= [];

        _headers.push(value);

        return this;
    }

    public function headers(value:Array):RestClient
    {
        _headers = value;

        removeDefaultHeaders = true;

        return this;
    }

    //------------------------------------
    //  params
    //------------------------------------

    private var _params:Object;

    public function addParam(key:String, value:Object, defaultValue:Object = null):RestClient
    {
        value = value || defaultValue;

        if (value != null)
        {
            _params ||= {};

            _params[key] = String(value);
        }

        return this;
    }

    public function params(value:Object):RestClient
    {
        _params = value;

        return this;
    }

    //------------------------------------
    //  contentType
    //------------------------------------

    private var _contentType:String = "application/json";

    public function contentType(value:String):RestClient
    {
        _contentType = value;

        return this;
    }

    //------------------------------------
    //  accessToken
    //------------------------------------

    private var accessTokenSpecified:Boolean = false;

    private var _accessTokenKey:String;
    private var _accessTokenValue:String;

    public function accessToken(value:String, key:String = "access_token"):RestClient
    {
        _accessTokenValue = value;
        _accessTokenKey = key;

        accessTokenSpecified = true;

        return this;
    }

    //------------------------------------
    //  encoder
    //------------------------------------

    private var _encoder:Function;

    public function encoder(value:Function):RestClient
    {
        _encoder = value;

        return this;
    }

    private var _decoder:Function;

    //------------------------------------
    //  decoder
    //------------------------------------

    public function decoder(value:Function):RestClient
    {
        _decoder = value;

        return this;
    }

    //------------------------------------
    //  errorHook
    //------------------------------------

    internal var errorInterceptor:Function = Config.sharedInstance().errorHook;

    public function errorHook(hook:Function):RestClient
    {
        errorInterceptor = hook;

        return this;
    }

    //------------------------------------
    //  result
    //------------------------------------

    internal var resultCallback:Function;

    public function result(handler:Function):RestClient
    {
        resultCallback = handler;

        return this;
    }

    //------------------------------------
    //  progress
    //------------------------------------

    internal var progressCallback:Function;

    public function progress(handler:Function):RestClient
    {
        progressCallback = handler;

        return this;
    }

    //------------------------------------
    //  status
    //------------------------------------

    internal var statusCallback:Function;

    public function status(handler:Function):RestClient
    {
        statusCallback = handler;

        return this;
    }

    //------------------------------------
    //  error
    //------------------------------------

    internal var errorCallback:Function;

    public function error(handler:Function):RestClient
    {
        errorCallback = handler;

        return this;
    }

    //------------------------------------
    //  header
    //------------------------------------

    internal var headerCallbacks:Object = {};

    public function header(name:String, handler:Function):RestClient
    {
        headerCallbacks[name] = handler;

        return this;
    }

    internal function hasHeaderCallbacks():Boolean
    {
        for (var p:String in headerCallbacks)
            return true;

        return false;
    }

    //------------------------------------
    //  http
    //------------------------------------

    public function get():void
    {
        send(URLRequestMethod.GET);
    }

    public function post(data:Object = null):void
    {
        send(URLRequestMethod.POST, data);
    }

    public function put(data:Object = null):void
    {
        send(URLRequestMethod.PUT, data);
    }

    public function del(data:Object = null):void
    {
        send(URLRequestMethod.DELETE, data);
    }

    public function download(data:Object = null):void
    {
        // TODO: Add downloading large files.
    }

    private function send(method:String, data:Object = null):void
    {
        request = new URLRequest(formURL());
        request.method = method;
        request.contentType = _contentType;

        if (_headers != null)
            request.requestHeaders = request.requestHeaders.concat(_headers);

        loader = loader || new URLLoader();
        loader.dataFormat = URLLoaderDataFormat.TEXT;

        URLLoaderHandlerFactory.create(this).handle(loader);

        if (data != null)
        {
            encodeRequest(data,
                function(data:Object):void
                {
                    request.data = data;

                    loader.load(request);
                }
            );
        }
        else
        {
            loader.load(request);
        }
    }

    skein_internal function retry():void
    {
        if (loader != null && request != null)
        {
            request.url = formURL();

            loader.load(request);
        }
    }

    public function url():String
    {
        return formURL();
    }

    //--------------------------------------------------------------------------
    //
    //  Internal Methods
    //
    //--------------------------------------------------------------------------

    internal function free():void
    {
        if (loader != null)
        {
            try
            {
                loader.close();
            }
            catch(error:Error)
            {
                // ignore any error
            }
        }

        _headers = null;
        _params = null;
        _contentType = "application/json";
        _accessTokenKey = null;
        _accessTokenValue = null;
        accessTokenSpecified = false;
        _encoder = null;
        _decoder = null;

        errorInterceptor = Config.sharedInstance().errorHook;

        resultCallback = null
        progressCallback = null;
        errorCallback = null;
        headerCallbacks = {};

        RestClientRegistry.free(this);
    }

    private function formURL():String
    {
        var urlParams:String = encodeParams();

        return urlParams ? _url + "?" + urlParams : _url;
    }

    private function encodeRequest(data:Object, callback:Function):void
    {
        if (_encoder != null)
        {
            _encoder(data, callback);
        }
        else
        {
            Encoder.forType(_contentType)(data, callback);
        }
    }

    internal function decodeResult(data:Object, callback:Function):void
    {
        if (_decoder)
        {
            _decoder(data, callback);
        }
        else if (!data)
        {
            if (callback.length == 1)
                callback(data);
            else
                callback();
        }
        else
        {
            Decoder.forType(_contentType)(data, callback);
        }
    }

    internal function decodeError(info:Object, callback:Function):void
    {
        Decoder.forType(_contentType)(info, callback);
    }

    private function encodeParams():String
    {
        if (accessTokenSpecified)
        {
            if (_accessTokenValue)
            {
                addParam(_accessTokenKey, _accessTokenValue);
            }
            else
            {
                // ignore default token
            }
        }
        else if (Config.sharedInstance().accessToken)
        {
            addParam(Config.sharedInstance().accessTokenKey, Config.sharedInstance().accessToken);
        }

        if (_params)
        {
            var variables:URLVariables = new URLVariables();

            for (var p:String in _params)
            {
                variables[p] = _params[p];
            }

            return variables.toString();
        }
        else
        {
            return "";
        }
    }
}
}
