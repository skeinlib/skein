/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/17/13
 * Time: 6:57 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.impl.rest
{
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;

import mx.utils.StringUtil;

import skein.rest.core.Config;
import skein.rest.core.Decoder;
import skein.rest.core.Encoder;
import skein.rest.rest.RestClient;

public class DefaultRestClient implements RestClient
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function DefaultRestClient(api:String, params:Array)
    {
        super();

        url = Config.sharedInstance().rest + StringUtil.substitute(api, params);
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var url:String;

    private var loader:URLLoader;

    private var request:URLRequest;

    //

    private var removeDefaultHeaders:Boolean = false;

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

    public function addParam(key:String, value:String):RestClient
    {
        _params ||= {};

        _params[key] = value;

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

    private var resultCallback:Function;

    public function result(handler:Function):RestClient
    {
        resultCallback = handler;

        return this;
    }

    private var statusCallback:Function;

    public function status(handler:Function):RestClient
    {
        statusCallback = handler;

        return this;
    }

    private var errorCallback:Function;

    public function error(handler:Function):RestClient
    {
        errorCallback = handler;

        return this;
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

    public function del():void
    {
        send(URLRequestMethod.DELETE);

        if (_decoder)
        {
            _decoder()
        }
    }

    private function send(method:String, data:Object=null):void
    {
        function resultHandler(event:Event):void
        {
            loader.removeEventListener(Event.COMPLETE, resultHandler);
            loader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);

            if (resultCallback != null)
            {
                decodeResponse(loader.data, resultCallback);
            }
        }

        function errorHandler(event:ErrorEvent):void
        {
            loader.removeEventListener(Event.COMPLETE, resultHandler);
            loader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);

            if (errorCallback != null)
            {
                decodeResponse(loader.data, errorCallback);
            }
        }

        function statusHandler(event:HTTPStatusEvent):void
        {
            if (statusCallback != null)
                statusCallback(event.status);
        }

        var urlParams:String = encodeParams();

        var finalURL:String = urlParams ? url + "?" + urlParams : url;

        var request:URLRequest = new URLRequest(finalURL);
        request.method = method;
        request.contentType = _contentType;

        var loader:URLLoader = new URLLoader();
        loader.dataFormat = URLLoaderDataFormat.TEXT;
        loader.addEventListener(Event.COMPLETE, resultHandler);
        loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, statusHandler);
        loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
        loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);

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

    //--------------------------------------------------------------------------
    //
    //
    //
    //--------------------------------------------------------------------------

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

    private function decodeResponse(data:Object, callback:Function):void
    {
        if (_decoder)
        {
            _decoder(data, callback);
        }
        else
        {
            Decoder.forType(_contentType)(data, callback);
        }
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
