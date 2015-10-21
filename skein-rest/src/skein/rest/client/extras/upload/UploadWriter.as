/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/23/14
 * Time: 1:50 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client.extras.upload
{
public interface UploadWriter
{
    function close():void;

    function load(from:Object, to:Object, contentType:String, fields:Object = null):void;

    function errorCallback(callback:Function):void;

    function completeCallback(callback:Function):void;

    function responseCallback(callback:Function):void;

    function statusCallback(callback:Function):void;
}
}
