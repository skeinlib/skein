/**
 * Created by mobitile on 11/3/14.
 */
package skein.locale.core
{
public interface SourceLoader
{
    function addCompleteCallback(callback:Function):void;
    function removeCompleteCallback(callback:Function):void;

    function addErrorCallback(callback:Function):void;
    function removeErrorCallback(callback:Function):void;

    function load(path:String):void;

    function close():void;

    function dispose():void;
}
}
