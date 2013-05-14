/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 5:16 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.states.builder
{
public interface StateOverrideBuilder
{
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    // Methods: Generic
    //------------------------------------

    function set(property:String, value:Object):StateOverrideBuilder;

    function call(method:String, arguments:Array):StateOverrideBuilder;

    //------------------------------------
    // Methods: Position
    //------------------------------------

    function move(x:Object, y:Object):StateOverrideBuilder;

    function x(x:Object):StateOverrideBuilder;

    function y(x:Object):StateOverrideBuilder;

    //------------------------------------
    // Methods: Size
    //------------------------------------

    function size(w:Object, h:Object):StateOverrideBuilder;

    function width(value:Object):StateOverrideBuilder;

    function height(h:Object):StateOverrideBuilder;

    //------------------------------------
    // Methods: Component
    //------------------------------------

    function enable():StateOverrideBuilder;

    function disable():StateOverrideBuilder;

    //------------------------------------
    // Methods: Events
    //------------------------------------

    function on(event:String, handler:Function):StateOverrideBuilder;

    function removeHandler(event:String, handler:Function):StateOverrideBuilder;

    function end():StateBuilder;

}
}
