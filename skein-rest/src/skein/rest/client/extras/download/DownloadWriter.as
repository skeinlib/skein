/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/7/14
 * Time: 12:31 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client.extras.download
{
import flash.utils.ByteArray;

public interface DownloadWriter
{
    function start(to:Object):void;

    function close():void;

    function write(bytes:ByteArray, last:Boolean = false):void;

    function errorCallback(callback:Function):void;

    function completeCallback(callback:Function):void;
}
}
