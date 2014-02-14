/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 12/28/13
 * Time: 6:09 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes.core
{
public interface ShareWriter
{
    function setTarget(target:Object):void;

    function write(index:Number, chunkSize:uint, chunk:Object, callback:Function):void;
}
}
