/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/20/13
 * Time: 12:27 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.components
{
import skein.components.builder.Builder;

public interface TextInputBuilder extends Builder
{
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-----------------------------------
    //  Methods: Object
    //-----------------------------------

    function set(property:String, value:Object):TextInputBuilder;

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    function on(type:String, handler:Function, weak:Boolean=true):TextInputBuilder;

    //-----------------------------------
    //  Methods: Sprite
    //-----------------------------------

    function x(value:Object):TextInputBuilder;

    function y(value:Object):TextInputBuilder;

    function z(value:Object):TextInputBuilder;

    function width(value:Object):TextInputBuilder;

    function height(value:Object):TextInputBuilder;

    function visible(value:Object):TextInputBuilder;

    function alpha(value:Object):TextInputBuilder;

    function rotation(value:Object, axis:String=null):TextInputBuilder;

    function scale(value:Object, axis:String=null):TextInputBuilder;

    function mask(value:Object):TextInputBuilder;

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    function id(id:Object):TextInputBuilder;

    function styleName(value:Object):TextInputBuilder;

    function enabled(value:Object):TextInputBuilder;

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    function left(value:Object):TextInputBuilder;

    function top(value:Object):TextInputBuilder;

    function right(value:Object):TextInputBuilder;

    function bottom(value:Object):TextInputBuilder;

    function horizontalCenter(value:Object):TextInputBuilder;

    function verticalCenter(value:Object):TextInputBuilder;

    //-----------------------------------
    //  Methods: TextInputBuilder
    //-----------------------------------

    function text(value:Object):TextInputBuilder;

    function prompt(value:Object):TextInputBuilder;

    function restrict(value:Object):TextInputBuilder;

    function editable(value:Object):TextInputBuilder;

    function multiline(value:Object):TextInputBuilder;

    function wordWrap(value:Object):TextInputBuilder;

    function displayAsPassword(value:Object):TextInputBuilder;

    function textAlign(value:Object):TextInputBuilder;

    function maxChars(value:Object):TextInputBuilder;

    function softKeyboardType(value:Object):TextInputBuilder;

    function autoCapitalize(value:Object):TextInputBuilder;
}
}
