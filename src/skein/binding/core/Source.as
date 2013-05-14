/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/22/13
 * Time: 11:30 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.core
{
public interface Source
{
    function setCallback(value:Function):void;

    function getValue():Object;

    function dispose():void;
}
}
