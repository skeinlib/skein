/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 12/28/13
 * Time: 6:09 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes.core
{
public interface ShareReader
{
    function setSource(source:Object, size:uint):void;

    function read(index:Number, chunkSize:uint, callback:Function):void;

//    function read(offset:int, length:int, callback:Function):void;
}
}
