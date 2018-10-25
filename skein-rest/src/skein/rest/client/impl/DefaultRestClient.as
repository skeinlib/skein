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
import flash.system.ApplicationDomain;
import flash.system.Capabilities;
import flash.system.LoaderContext;
import flash.utils.ByteArray;
import flash.utils.Timer;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

import skein.core.skein_internal;
import skein.logger.Log;
import skein.rest.cache.CacheClient;
import skein.rest.client.RestClient;
import skein.rest.client.extras.Downloader;
import skein.rest.client.extras.Uploader;
import skein.rest.client.impl.extras.DownloaderHandler;
import skein.rest.client.impl.extras.UploaderHandler;
import skein.rest.core.Config;
import skein.rest.core.Decoder;
import skein.rest.core.Encoder;
import skein.rest.core.ProgressTracker;
import skein.rest.core.RestClientRegistry;
import skein.rest.core.coding.DefaultCoding;
import skein.utils.StringSubstituteArguments;
import skein.utils.StringUtil;

use namespace skein_internal;

public class DefaultRestClient implements RestClient
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    private static const DEFAULT_CONTENT_TYPE:String = "application/json";

    private static const DEFAULT_RESPONSE_CONTENT_TYPE:String = DEFAULT_CONTENT_TYPE;

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function DefaultRestClient()
    {
        super();

        Log.d("skein-rest", "DefaultRestClient");
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    protected var _path:String;
    protected var _pathParams:Array;

    internal var loader:URLLoader;

    internal var request:URLRequest;

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

    public function init(path:String, params:Array):void
    {
        _path = path;

        if (params.length == 1 && params[0] is StringSubstituteArguments) {
            _pathParams = StringSubstituteArguments(params[0]).value;
        } else {
            _pathParams = params;
        }
    }

    protected function get path():String
    {
        if (_path.indexOf("http") == 0 || _path.indexOf("file") == 0 || _path.indexOf("app") == 0)
        {
            return StringUtil.substitute(_path, _pathParams);
        }
        else
        {
            return Config.sharedInstance().rest + StringUtil.substitute(_path, _pathParams);
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
        if (!value)
        {
            if (!(value is Boolean) && !(value is Number && !isNaN(value as Number)))
            {
                value = defaultValue;
            }
        }

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

    private var _contentType:String = DEFAULT_CONTENT_TYPE;

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

    //------------------------------------
    //  responseContentType
    //------------------------------------

    private var _requestedResponseContentType:String = DEFAULT_RESPONSE_CONTENT_TYPE;

    public function requestedResponseContentType(value:String):RestClient
    {
        _requestedResponseContentType = value;

        return this;
    }

    private var _actualResponseContentType:String = null;

    skein_internal function setResponseContentType(value:String):void
    {
        _actualResponseContentType = value;
    }

    private function getResponseContentType():String
    {
        return _actualResponseContentType || _requestedResponseContentType;
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

    private var _encoder: Function;
    public function encoder(value: Function): RestClient {
        _encoder = value;
        return this;
    }

    //------------------------------------
    //  decoder
    //------------------------------------

    private var _decoder: Function;
    public function decoder(value: Function): RestClient {
        _decoder = value;
        return this;
    }

    //------------------------------------
    //  errorDecoder
    //------------------------------------

    public var _errorDecoder: Function;
    public function errorDecoder(value: Function): RestClient {
        _errorDecoder = value;
        return this;
    }

    //------------------------------------
    //  beforeResultHook
    //------------------------------------

    internal var beforeResultInterceptor: Function = Config.sharedInstance().beforeResultHook;
    public function beforeResultHook(hook: Function): RestClient {
        beforeResultInterceptor = hook;
        return this;
    }

    //------------------------------------
    //  afterResultHook
    //------------------------------------

    internal var afterResultInterceptor: Function = Config.sharedInstance().afterResultHook;
    public function afterResultHook(hook: Function):RestClient {
        afterResultInterceptor = hook;
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
    //  timeout
    //------------------------------------

    internal var _timeout:Number = NaN;

    public function timeout(value:Number):RestClient
    {
        _timeout = value;

        return this;
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
    //  cache
    //------------------------------------

    internal var _cache:CacheClient = Config.sharedInstance().cache;

    public function cache(value:CacheClient):RestClient
    {
        _cache = value;

        return this;
    }

    internal var _useCache:Boolean = Config.sharedInstance().useCache;

    public function useCache(value:Boolean):RestClient
    {
        _useCache = value;

        return this;
    }

    private var _forceCache:Boolean = false;

    public function forceCache(value:Boolean):RestClient
    {
        _forceCache = value;

        return this;
    }

    private function get canUseCache():Boolean
    {
        return _useCache && _cache != null;
    }

    //------------------------------------
    //  http
    //------------------------------------

    public function get():Object
    {
        send(URLRequestMethod.GET);

        return loader;
    }

    public function post(data:Object = null):Object
    {
        send(URLRequestMethod.POST, data);

        return loader;
    }

    public function put(data:Object = null):Object
    {
        send(URLRequestMethod.PUT, data);

        return loader;
    }

    public function patch(data:Object = null):Object
    {
        send("PATCH", data);

        return loader;
    }

    public function del(data:Object = null):Object
    {
        if (data != null && Config.sharedInstance().fixKnownIssues && Capabilities.version.substr(0, 3) == "AND")
        {
            // fixes issue with empty BODY for DELETE method on Android platform

            addHeader(new URLRequestHeader("X-HTTP-Method-Override", "DELETE"));
            send(URLRequestMethod.POST, data);
        }
        else
        {
            send(URLRequestMethod.DELETE, data);
        }

        return loader;
    }

    public function download(to: Object, method: String = "GET", data: Object = null): void
    {
        downloadTo = to;

        downloader = downloader || new Downloader();

        new DownloaderHandler(this).handle(downloader);

        createRequest(method, data, function(): void {
            doDownload();
        });
    }

    private function doDownload(): void {
        downloader.download(request, downloadTo);
    }

    public function upload(from:Object):void
    {
        uploadFrom = from;

        uploader = uploader || new Uploader();

        new UploaderHandler(this).handle(uploader);

        request = new URLRequest(createURL());

        uploader.upload(uploadFrom, request, getRequestContentType(uploadFrom), _fields);
    }

    //------------------------------------
    //  loader
    //------------------------------------

    private function send(method:String, data:Object = null):void {

        createRequest(method, data, function(): void {
            load();
        });
    }

    private function load():void
    {
        var isOwnedLoader:Boolean = true;

        if (loader == null)
        {
            loader = URLLoadersQueue.find(request);

            if (loader == null)
            {
                loader = new URLLoader();
            }
            else
            {
                isOwnedLoader = false;
            }
        }

        URLLoadersQueue.keep(request, loader);

        if (_requestedResponseContentType == "application/octet-stream")
            loader.dataFormat = URLLoaderDataFormat.BINARY;
        else
            loader.dataFormat = URLLoaderDataFormat.TEXT;

        URLLoaderHandlerFactory.create(this).handle(loader);

        if (isOwnedLoader)
        {
            if (stubValue != null)
            {
                doStub();
            }
            else
            {
                doLoad();
            }
        }
    }

    private function doStub():void
    {
        Log.i("skein-rest", URLLoadersQueue.name(loader) + " *STUB* " + request.method.toUpperCase() + " " + request.url + (request.data ? " -> " + request.data : ""));

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

    private function doLoad():void
    {
        if (_useCache && _cache != null)
        {
            if (_cache.live(request) || _forceCache)
            {
                _cache.find(request, function(response:Object):void
                {
                    if (response != null)
                    {
                        loader.data = response.data;

                        loader.dispatchEvent(new HTTPStatusEvent(HTTPStatusEvent.HTTP_STATUS, false, false, 200));
                        loader.dispatchEvent(new Event(Event.COMPLETE));
                    }
                    else // not yet in cache
                    {
                        doLoadFromResource();
                    }
                });
            }
            else
            {
                _cache.find(request, function(response:Object):void
                {
                    if (response != null)
                    {
                        request.requestHeaders = request.requestHeaders.concat(response.headers);
                    }

                    // TODO(dev) should it be "else" here?
                    doLoadFromResource();
                });
            }
        }
        else
        {
            doLoadFromResource();
        }
    }

    private function doLoadFromResource(): void {
        Log.i("skein-rest", URLLoadersQueue.name(loader) + " " + request.method.toUpperCase() + " " + request.url + (request.data ? " -> " + request.data : ""));
        loader.load(request);
    }

    skein_internal function retry():Boolean
    {
        if (loader != null && request != null)
        {
            request.url = createURL();

            doLoadFromResource();

            return true;
        }
        else if (downloader != null && downloadTo != null && request != null)
        {
            request.url = createURL();
            downloader.download(request, downloadTo);

            return true;
        }
        else if (uploader != null && uploadFrom != null && request != null)
        {
            request.url = createURL();
            uploader.upload(uploadFrom, request, getRequestContentType(uploadFrom), _fields);

            return true;
        }

        return false;
    }

    public function url():String
    {
        return createURL();
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
            loader.dataFormat = URLLoaderDataFormat.TEXT;

            try
            {
                loader.close();
            }
            catch(error:Error)
            {
                // ignore any error
            }

            /* If URLLoadersQueue.free() returns false it indicates that
             * the loader was already removed from Queue it means that this
             * loader is shared between DefaultRestClients instances. That's
             * because we can't reuse this loader here, because it is already
             * reused by other DefaultRestClient instance.
             */
            if (!URLLoadersQueue.free(loader))
            {
                // remove reference to URLLoader as it is shared instance

                loader = null;
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

        _path = null;
        _pathParams = null;
        request = null;
        downloadTo = null;
        uploadFrom = null;

        _headers = null;
        _params = null;
        _fields = null;
        _contentType = DEFAULT_CONTENT_TYPE;
        _actualResponseContentType = null;
        _requestedResponseContentType = DEFAULT_RESPONSE_CONTENT_TYPE;
        _accessTokenKey = null;
        _accessTokenValue = null;
        accessTokenSpecified = false;
        _encoder = null;
        _decoder = null;

        beforeResultInterceptor = Config.sharedInstance().beforeResultHook;
        afterResultInterceptor = Config.sharedInstance().afterResultHook;
        errorInterceptor = Config.sharedInstance().errorHook;

        resultCallback = null;
        progressCallback = null;
        errorCallback = null;
        statusCallback = null;
        headerCallbacks = {};

        _timeout = NaN;

        stubValue = null;
        stubDelay = 0;

        _cache = Config.sharedInstance().cache;
        _useCache = Config.sharedInstance().useCache;
        _forceCache = false;

        RestClientRegistry.reuse(this);
    }

    private function createURL():String
    {
        var urlParams:String = encodeParams();

        return urlParams ? path + "?" + urlParams : path;
    }

    private function createRequest(method: String, data: Object = null, callback: Function = null): void {

        request = new URLRequest(createURL());
        request.method = method;
        request.contentType = _contentType;

        request.requestHeaders = request.requestHeaders.concat(gatherRequestHeaders());

        if (!isNaN(_timeout) && Object(request).hasOwnProperty("idleTimeout")) {
            request["idleTimeout"] = _timeout;
        }

        if (data != null) {
            encodeRequest(data,
                function(encodedData: Object, contentType: String = null):void {
                    request.data = encodedData;

                    if (contentType != null) {
                        request.contentType = contentType;
                    }

                    if (callback != null) {
                        callback();
                    }
                }
            );
        } else {
            if (callback != null) {
                callback();
            }
        }
    }

    private function gatherRequestHeaders(): Array {
        var result: Array = [];

        var authorizationFound: Boolean = false;

        var n: int = _headers ? _headers.length : 0;
        for (var i: int = 0; i < n; i++) {
            var header: URLRequestHeader = _headers[i];
            if (header.name == "Authorization") {
                authorizationFound = true;
                if (Boolean(header.value)) {
                    result[result.length] = header;
                }
            } else {
                result[result.length] = header;
            }
        }

        if (!authorizationFound && Config.sharedInstance().authorization) {
            result[result.length] = new URLRequestHeader("Authorization", Config.sharedInstance().authorization);
        }

        return result;
    }

    private function encodeRequest(data: Object, callback: Function): void {
        if (_encoder != null) {
            _encoder(data, callback);
        } else {
            Encoder.forType(getRequestContentType(data))(data, callback);
        }
    }

    internal function decodeResult(data: Object, callback: Function): void {
        getDecoderForDataWithPreferred(data, _decoder)(data, callback);
    }

    internal function decodeError(info:Object, responseCode: int, callback:Function):void {
        var decoder: Function = getDecoderForDataWithPreferred(info, _errorDecoder || Config.sharedInstance().errorDecoder);
        if (decoder.length == 3) {
            decoder(info, responseCode, callback);
        } else {
            decoder(info, callback);
        }
    }

    private function getDecoderForDataWithPreferred(data: Object, preferredDecoder: Function): Function {
        if (preferredDecoder != null) {
            return preferredDecoder;
        }
        if (getQualifiedClassName(data) == "flash.filesystem::File") {
            return DefaultCoding.decode;
        }
        if (data == null) {
            return DefaultCoding.decode;
        }
        return Decoder.forType(getResponseContentType());
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

    internal function handleResult(data:Object, responseCode:uint, headers:Array, callback:Function):void
    {
        handleProgress(true);

        if (_useCache && _cache != null)
        {
            if (responseCode == 304) // NotModified
            {
                _cache.find(request, function(response:Object):void
                {
                    notifyResult(response ? response.data : null, responseCode); // TODO: If data for unmodified response is not found in cache?

                    callback();
                });
            }
            else
            {
                notifyResult(data, responseCode);

                _cache.keep(request, data, headers, function(value:*=undefined):void
                {
                    callback();
                });
            }
        }
        else
        {
            notifyResult(data, responseCode);

            callback();
        }
    }

    private function notifyResult(data:Object, responseCode:uint):void
    {
        if (resultCallback != null)
        {
            if (resultCallback.length == 2)
                resultCallback(data, responseCode);
            else if (resultCallback.length == 1)
                resultCallback(data);
            else
                resultCallback();
        }
    }

    internal function handleError(info:Object, responseCode:uint):void
    {
        handleProgress(true);

        notifyError(info, responseCode);
    }

    private function notifyError(info:Object, responseCode:uint):void
    {
        if (errorCallback != null)
        {
            if (errorCallback.length == 2)
                errorCallback(info, responseCode);
            else
                errorCallback(info);
        }
    }

    internal function handleProgress(complete:Boolean, loaded:Number=NaN, total:Number=NaN):void
    {
        if (complete)
        {
            ProgressTracker.complete(this);
        }
        else
        {
            ProgressTracker.progress(this, loaded, total);

            notifyProgress(loaded, total);
        }

        if (Config.sharedInstance().progressHandler != null)
        {
            Config.sharedInstance().progressHandler(ProgressTracker.loaded, ProgressTracker.total);
        }
    }

    private function notifyProgress(loaded:Number, total:Number):void
    {
        if (progressCallback != null)
            progressCallback(loaded, total);
    }
}
}
