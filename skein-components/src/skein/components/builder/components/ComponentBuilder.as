/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/10/13
 * Time: 12:09 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.components
{
import skein.components.builder.Builder;

public interface ComponentBuilder extends Builder
{
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    function on(type:String, handler:Function, weak:Boolean=true):ComponentBuilder;

    //-----------------------------------
    //  Methods: Sprite
    //-----------------------------------

    function x(value:Object):ComponentBuilder;

    function y(value:Object):ComponentBuilder;

    function z(value:Object):ComponentBuilder;

    function width(value:Object):ComponentBuilder;

    function height(value:Object):ComponentBuilder;

    function visible(value:Object):ComponentBuilder;

    function alpha(value:Object):ComponentBuilder;

    function rotation(value:Object, axis:String=null):ComponentBuilder;

    function scale(value:Object, axis:String=null):ComponentBuilder;

    function mask(value:Object):ComponentBuilder;

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    function left(value:Object):ComponentBuilder;

    function top(value:Object):ComponentBuilder;

    function right(value:Object):ComponentBuilder;

    function bottom(value:Object):ComponentBuilder;

    function horizontalCenter(value:Object):ComponentBuilder;

    function verticalCenter(value:Object):ComponentBuilder;

    function includeInLayout(value:Object):ComponentBuilder;

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    function id(id:Object):ComponentBuilder;

    function styleName(value:Object):ComponentBuilder;

    function enabled(value:Object):ComponentBuilder;

    function set(property:String, value:Object):ComponentBuilder;
}
}
