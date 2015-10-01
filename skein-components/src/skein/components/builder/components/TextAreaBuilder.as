/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/10/13
 * Time: 2:02 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.components
{
import skein.components.builder.Builder;

public interface TextAreaBuilder extends Builder
{
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    function on(type:String, handler:Function, weak:Boolean=true):TextAreaBuilder;

    //-----------------------------------
    //  Methods: Sprite
    //-----------------------------------

    function x(value:Object):TextAreaBuilder;

    function y(value:Object):TextAreaBuilder;

    function z(value:Object):TextAreaBuilder;

    function width(value:Object):TextAreaBuilder;

    function height(value:Object):TextAreaBuilder;

    function visible(value:Object):TextAreaBuilder;

    function alpha(value:Object):TextAreaBuilder;

    function rotation(value:Object, axis:String=null):TextAreaBuilder;

    function scale(value:Object, axis:String=null):TextAreaBuilder;

    function mask(value:Object):TextAreaBuilder;

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    function id(id:Object):TextAreaBuilder;

    function styleName(value:Object):TextAreaBuilder;

    function enabled(value:Object):TextAreaBuilder;

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    function left(value:Object):TextAreaBuilder;

    function top(value:Object):TextAreaBuilder;

    function right(value:Object):TextAreaBuilder;

    function bottom(value:Object):TextAreaBuilder;

    function horizontalCenter(value:Object):TextAreaBuilder;

    function verticalCenter(value:Object):TextAreaBuilder;

    //-----------------------------------
    //  Methods: TextArea
    //-----------------------------------
    
    function text(value:Object):TextAreaBuilder;

    function restrict(value:Object):TextAreaBuilder;

    function editable(value:Object):TextAreaBuilder;

    function maxChars(value:Object):TextAreaBuilder;

    function softKeyboardType(value:Object):TextAreaBuilder;

    function autoCapitalize(value:Object):TextAreaBuilder;
}
}
