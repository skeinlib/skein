/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/24/13
 * Time: 10:53 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.states
{
public interface Override
{
    function get property():String;

    function get name():String;

    function get value():Object;

    function setState(value:State):void;

    function equals(that:Override):Boolean;

    function apply(host:Object):void;

    function remove(host:Object):void;
}
}
