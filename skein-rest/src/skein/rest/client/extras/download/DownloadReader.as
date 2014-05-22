/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/7/14
 * Time: 12:20 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client.extras.download
{
import flash.utils.ByteArray;

public interface DownloadReader
{
    function start(from:Object):void;

    function close():void;

    function getBytes():ByteArray;

    function progressCallback(callback:Function):void;

    function completeCallback(callback:Function):void;

    function errorCallback(callback:Function):void;
}
}
