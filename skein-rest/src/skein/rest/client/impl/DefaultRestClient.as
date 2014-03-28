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
        _url = Config.sharedInstance().rest + StringUtil.substitute(api, params);
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

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

    private var _contentType:String = "application/json";

    public function contentType(value:String):RestClient
    {
        _contentType = value;

        return this;
    }

    private var _accessTokenKey:String;
    private var _accessTokenValue:String;

    public function accessToken(value:String, key:String = "access_token"):RestClient
    {
        _accessTokenValue = value;
        _accessTokenKey = key;

        return this;
    }

    private var _encoder:Function;

    public function encoder(value:Function):RestClient
    {
        _encoder = value;

        return this;
    }

    private var _decoder:Function;

    public function decoder(value:Function):RestClient
    {
        _decoder = value;

        return this;
    }

    internal var resultCallback:Function;

    public function result(handler:Function):RestClient
    {
        resultCallback = handler;

        return this;
    }

    internal var progressCallback:Function;

    public function progress(handler:Function):RestClient
    {
        progressCallback = handler;

        return this;
    }

    internal var statusCallback:Function;

    public function status(handler:Function):RestClient
    {
        statusCallback = handler;

        return this;
    }

    internal var errorCallback:Function;

    public function error(handler:Function):RestClient
    {
        errorCallback = handler;

        return this;
    }

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
        var request:URLRequest = new URLRequest(formURL());
        request.method = method;
        request.contentType = _contentType;

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
        _encoder = null;
        _decoder = null;

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
        if (_accessTokenValue)
        {
            addParam(_accessTokenKey, _accessTokenValue);
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
