/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/17/13
 * Time: 6:57 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client.impl
{
import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.TimerEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.net.URLRequestHeader;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.utils.ByteArray;
import flash.utils.Timer;

import mx.utils.StringUtil;

import skein.core.skein_internal;
import skein.rest.client.RestClient;
import skein.rest.client.extras.Downloader;
import skein.rest.client.extras.Uploader;
import skein.rest.client.impl.extras.DownloaderHandler;
import skein.rest.client.impl.extras.UploaderHandler;
import skein.rest.core.Config;
import skein.rest.core.Decoder;
import skein.rest.core.Encoder;
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

    protected var loader:URLLoader;

    protected var request:URLRequest;

    protected var uploader:Uploader;

    protected var downloader:Downloader;

    private var downloadTo:Object;

    private var uploadFrom:Object;

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
    //  fields
    //------------------------------------

    private var _fields:Object;

    public function addField(key:String, value:Object, defaultValue:Object = null):RestClient
    {
        value = value || defaultValue;

        if (value != null)
        {
            _fields ||= {};

            _fields[key] = String(value);
        }

        return this;
    }

    public function fields(value:Object):RestClient
    {
        _fields = value;

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

    private function getRequestContentType(data:Object = null):String
    {
        if (_contentType != null)
        {
            return _contentType;
        }
        else if (data is ByteArray)
        {
            return "application/octet-stream";
        }
        else
        {
            return null;
        }
    }

    private var _responseContentType:String = "application/json";

    skein_internal function setResponseContentType(value:String):void
    {
        _responseContentType = value;
    }

    private function getResponseContentType():String
    {
        return _responseContentType;
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
    //  stub
    //------------------------------------

    internal var stubDelay:uint;

    internal var stubValue:Object;

    public function stub(value:Object, delay:uint = 0):RestClient
    {
        stubValue = value;

        stubDelay = delay;

        return this;
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
        if (Config.sharedInstance().fixKnownIssues)
        {
            // fixes issue with empty BODY for DELETE method on Android platform

            addHeader(new URLRequestHeader("X-HTTP-Method-Override", "DELETE"));
            send(URLRequestMethod.POST, data);
        }
        else
        {
            send(URLRequestMethod.DELETE, data);
        }
    }

    public function download(to:Object):void
    {
        downloadTo = to;

        downloader = downloader || new Downloader();

        new DownloaderHandler(this).handle(downloader);

        downloader.download(formURL(), downloadTo);
    }

    public function upload(from:Object):void
    {
        uploadFrom = from;

        uploader = uploader || new Uploader();

        new UploaderHandler(this).handle(uploader);

        uploader.upload(uploadFrom, formURL(), getRequestContentType(uploadFrom), _fields);
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

                    load();
                }
            );
        }
        else
        {
            load();
        }
    }

    private function load():void
    {
        if (stubValue != null)
        {
            var receiveStubData:Function = function():void
            {
                loader.data = stubValue is Function ? (stubValue as Function).apply() : stubValue;

                loader.dispatchEvent(new HTTPStatusEvent(HTTPStatusEvent.HTTP_STATUS, false, false, 200));
                loader.dispatchEvent(new Event(Event.COMPLETE));
            };

            if (stubDelay > 0)
            {
                var timer:Timer = new Timer(stubDelay, 1);
                timer.addEventListener(TimerEvent.TIMER_COMPLETE,
                    function(event:TimerEvent):void
                    {
                        timer.removeEventListener(TimerEvent.TIMER_COMPLETE, arguments.callee);

                        receiveStubData();
                    });

                timer.start();
            }
            else
            {
                receiveStubData();
            }
        }
        else
        {
            loader.load(request);

//            trace("[skein] DefaultRestClient:", request.method + ":" + request.url, "DATA:" + request.data);
        }
    }

    skein_internal function retry():void
    {
        if (loader != null && request != null)
        {
            request.url = formURL();

            loader.load(request);
        }
        else if (downloader != null && downloadTo != null)
        {
            downloader.download(formURL(), downloadTo);
        }
        else if (uploader != null && uploadFrom != null)
        {
            uploader.upload(uploadFrom, formURL(), getRequestContentType(uploadFrom), _fields);
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

        if (downloader != null)
        {
            try
            {
                downloader.close();
                downloader = null;
            }
            catch(error:Error)
            {
                // ignore any error
            }
        }

        if (uploader != null)
        {
            try
            {
                uploader.close();
                uploader = null;
            }
            catch(error:Error)
            {
                // ignore any error
            }
        }

        request = null;
        downloadTo = null;
        uploadFrom = null;

        _headers = null;
        _params = null;
        _fields = null;
        _contentType = "application/json";
        _responseContentType = "application/json";
        _accessTokenKey = null;
        _accessTokenValue = null;
        accessTokenSpecified = false;
        _encoder = null;
        _decoder = null;

        errorInterceptor = Config.sharedInstance().errorHook;

        resultCallback = null;
        progressCallback = null;
        errorCallback = null;
        headerCallbacks = {};

        stubValue = null;
        stubDelay = 0;

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
            Encoder.forType(getRequestContentType(data))(data, callback);
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
            Decoder.forType(getResponseContentType())(data, callback);
        }
    }

    internal function decodeError(info:Object, callback:Function):void
    {
        Decoder.forType(getResponseContentType())(info, callback);
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
