/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/17/13
 * Time: 6:27 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client
{
import skein.rest.cache.CacheClient;

public interface RestClient
{
    function init(path:String, params:Array):void;

    function addHeader(value:Object):RestClient;
    function headers(value:Array):RestClient;

    function addParam(key:String, value:Object, defaultValue:Object=null):RestClient;
    function params(value:Object):RestClient;

    function addField(key:String, value:Object, defaultValue:Object=null):RestClient;
    function fields(value:Object):RestClient;

    function accessToken(value:String, key:String = "access_token"):RestClient;

    function contentType(value:String):RestClient;
    function requestedResponseContentType(value:String):RestClient;

    function encoder(value:Function):RestClient;
    function decoder(value:Function):RestClient;

    function errorHook(hook:Function):RestClient;

    function progress(handler:Function):RestClient;
    function status(handler:Function):RestClient;
    function result(handler:Function):RestClient;
    function error(handler:Function):RestClient;

    function header(name:String, handler:Function):RestClient;
    
    function timeout(value:Number):RestClient;

    function stub(value:Object, delay:uint = 0):RestClient;

    function cache(value:CacheClient):RestClient;
    function useCache(value:Boolean):RestClient;
    function forceCache(value:Boolean):RestClient;

    function get():Object;
    function post(data:Object = null):Object;
    function put(data:Object = null):Object;
    function del(data:Object = null):Object;

    function download(to:Object):void;
    function upload(from:Object):void;

    function url():String;
}
}
