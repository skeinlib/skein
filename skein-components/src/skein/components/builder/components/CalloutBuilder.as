/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 1:44 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.components
{
import skein.components.builder.*;

public interface CalloutBuilder extends Builder
{
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    function on(type:String, handler:Function, weak:Boolean=true):CalloutBuilder;

    //-----------------------------------
    //  Methods: Sprite
    //-----------------------------------

    function x(value:Object):CalloutBuilder;

    function y(value:Object):CalloutBuilder;

    function z(value:Object):CalloutBuilder;

    function width(value:Object):CalloutBuilder;

    function height(value:Object):CalloutBuilder;

    function visible(value:Object):CalloutBuilder;

    function alpha(value:Object):CalloutBuilder;

    function rotation(value:Object, axis:String=null):CalloutBuilder;

    function scale(value:Object, axis:String=null):CalloutBuilder;

    function mask(value:Object):CalloutBuilder;

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    function id(id:Object):CalloutBuilder;

    function styleName(value:Object):CalloutBuilder;

    function enabled(value:Object):CalloutBuilder;

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    function left(value:Object):CalloutBuilder;

    function top(value:Object):CalloutBuilder;

    function right(value:Object):CalloutBuilder;

    function bottom(value:Object):CalloutBuilder;

    function horizontalCenter(value:Object):CalloutBuilder;

    function verticalCenter(value:Object):CalloutBuilder;

    //-----------------------------------
    //  Methods: Callout
    //-----------------------------------

    function content(value:Object):CalloutBuilder;

    function origin(value:Object):CalloutBuilder;

    function directions(value:Object):CalloutBuilder;

    function padding(value:Object, side:String = null):CalloutBuilder;

    function arrowGap(value:Object, side:String):CalloutBuilder;

    function arrowPosition(value:Object):CalloutBuilder;

    function arrowOffset(value:Object):CalloutBuilder;

}
}
