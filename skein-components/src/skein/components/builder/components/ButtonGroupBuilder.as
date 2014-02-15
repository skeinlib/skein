/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 1:39 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.components
{
import skein.components.builder.Builder;

public interface ButtonGroupBuilder extends Builder
{
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    function on(type:String, handler:Function, weak:Boolean=true):ButtonGroupBuilder;

    //-----------------------------------
    //  Methods: Sprite
    //-----------------------------------

    function x(value:Object):ButtonGroupBuilder;

    function y(value:Object):ButtonGroupBuilder;

    function z(value:Object):ButtonGroupBuilder;

    function width(value:Object):ButtonGroupBuilder;

    function height(value:Object):ButtonGroupBuilder;

    function visible(value:Object):ButtonGroupBuilder;

    function alpha(value:Object):ButtonGroupBuilder;

    function rotation(value:Object, axis:String=null):ButtonGroupBuilder;

    function scale(value:Object, axis:String=null):ButtonGroupBuilder;

    function mask(value:Object):ButtonGroupBuilder;

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    function id(id:Object):ButtonGroupBuilder;

    function styleName(value:Object):ButtonGroupBuilder;

    function enabled(value:Object):ButtonGroupBuilder;

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    function left(value:Object):ButtonGroupBuilder;

    function top(value:Object):ButtonGroupBuilder;

    function right(value:Object):ButtonGroupBuilder;

    function bottom(value:Object):ButtonGroupBuilder;

    function horizontalCenter(value:Object):ButtonGroupBuilder;

    function verticalCenter(value:Object):ButtonGroupBuilder;

    //-----------------------------------
    //  Methods: ButtonGroup
    //-----------------------------------

    function provider(value:Object):ButtonGroupBuilder;

    function gap(value:Object):ButtonGroupBuilder;

    function firstGap(value:Object):ButtonGroupBuilder;

    function lastGap(value:Object):ButtonGroupBuilder;

    function buttonFactory(value:Object):ButtonGroupBuilder;

    function firstButtonFactory(value:Object):ButtonGroupBuilder;

    function lastButtonFactory(value:Object):ButtonGroupBuilder;
}
}
