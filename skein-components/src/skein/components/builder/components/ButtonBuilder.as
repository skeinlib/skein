/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/19/13
 * Time: 5:23 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.components
{
import skein.components.builder.*;

public interface ButtonBuilder extends Builder
{
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    function on(type:String, handler:Function, weak:Boolean=true):ButtonBuilder;

    //-----------------------------------
    //  Methods: Sprite
    //-----------------------------------

    function x(value:Object):ButtonBuilder;

    function y(value:Object):ButtonBuilder;

    function z(value:Object):ButtonBuilder;

    function width(value:Object):ButtonBuilder;

    function height(value:Object):ButtonBuilder;

    function visible(value:Object):ButtonBuilder;

    function alpha(value:Object):ButtonBuilder;

    function rotation(value:Object, axis:String=null):ButtonBuilder;

    function scale(value:Object, axis:String=null):ButtonBuilder;

    function mask(value:Object):ButtonBuilder;

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    function id(id:Object):ButtonBuilder;

    function styleName(value:Object):ButtonBuilder;

    function enabled(value:Object):ButtonBuilder;

    function set(property:String, value:Object):ButtonBuilder;

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    function left(value:Object):ButtonBuilder;

    function top(value:Object):ButtonBuilder;

    function right(value:Object):ButtonBuilder;

    function bottom(value:Object):ButtonBuilder;

    function horizontalCenter(value:Object):ButtonBuilder;

    function verticalCenter(value:Object):ButtonBuilder;

    function includeInLayout(value:Object):ButtonBuilder;

    //-----------------------------------
    //  Methods: Button
    //-----------------------------------

    function label(value:Object):ButtonBuilder;

    function toggled(value:Object):ButtonBuilder;

    function selected(value:Object):ButtonBuilder;
}
}
