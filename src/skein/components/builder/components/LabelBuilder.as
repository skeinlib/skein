/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 12:56 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.components
{
import skein.components.builder.Builder;

public interface LabelBuilder extends Builder
{
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    function on(type:String, handler:Function, weak:Boolean=true):LabelBuilder;

    //-----------------------------------
    //  Methods: Sprite
    //-----------------------------------

    function x(value:Object):LabelBuilder;

    function y(value:Object):LabelBuilder;

    function z(value:Object):LabelBuilder;

    function width(value:Object):LabelBuilder;

    function height(value:Object):LabelBuilder;

    function visible(value:Object):LabelBuilder;

    function alpha(value:Object):LabelBuilder;

    function rotation(value:Object, axis:String=null):LabelBuilder;

    function scale(value:Object, axis:String=null):LabelBuilder;

    function mask(value:Object):LabelBuilder;

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    function id(id:Object):LabelBuilder;

    function styleName(value:Object):LabelBuilder;

    function enabled(value:Object):LabelBuilder;

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    function left(value:Object):LabelBuilder;

    function top(value:Object):LabelBuilder;

    function right(value:Object):LabelBuilder;

    function bottom(value:Object):LabelBuilder;

    function horizontalCenter(value:Object):LabelBuilder;

    function verticalCenter(value:Object):LabelBuilder;

    //-----------------------------------
    //  Methods: Label
    //-----------------------------------

    function text(value:Object):LabelBuilder;

    function textAlign(value:Object):LabelBuilder;

    function wordWrap(value:Object):LabelBuilder;

    function lineBreak(value:Object):LabelBuilder;
}
}
