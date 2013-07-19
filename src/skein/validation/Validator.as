/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/18/13
 * Time: 10:16 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.validation
{
import flash.events.IEventDispatcher;

public interface Validator extends IEventDispatcher
{
    function get source():Object;
    function set source(value:Object):void;

    function get property():String;
    function set property(value:String):void;

    function get triggerEvent():String;
    function set triggerEvent(value:String):void;

    function validate(value:Object=null):void;
}
}
