/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/19/13
 * Time: 5:40 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.components
{
import skein.components.builder.Builder;

public interface GroupBuilder extends Builder
{
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-----------------------------------
    //  Methods: Object
    //-----------------------------------

    function set(property:String, value:Object):GroupBuilder;

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    function on(type:String, handler:Function, weak:Boolean=true):GroupBuilder;

    //-----------------------------------
    //  Methods: Sprite
    //-----------------------------------

    function x(value:Object):GroupBuilder;

    function y(value:Object):GroupBuilder;

    function z(value:Object):GroupBuilder;

    function width(value:Object):GroupBuilder;

    function height(value:Object):GroupBuilder;

    function visible(value:Object):GroupBuilder;

    function alpha(value:Object):GroupBuilder;

    function rotation(value:Object, axis:String=null):GroupBuilder;

    function scale(value:Object, axis:String=null):GroupBuilder;

    function mask(value:Object):GroupBuilder;

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    function id(id:Object):GroupBuilder;

    function styleName(value:Object):GroupBuilder;

    function enabled(value:Object):GroupBuilder;

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    function left(value:Object):GroupBuilder;
    function leftAnchor(value:Object):GroupBuilder;

    function top(value:Object):GroupBuilder;
    function topAnchor(value:Object):GroupBuilder;

    function right(value:Object):GroupBuilder;
    function rightAnchor(value:Object):GroupBuilder;

    function bottom(value:Object):GroupBuilder;
    function bottomAnchor(value:Object):GroupBuilder;

    function horizontalCenter(value:Object):GroupBuilder;

    function verticalCenter(value:Object):GroupBuilder;

    function includeInLayout(value:Object):GroupBuilder;

    //-----------------------------------
    //  Methods: ElementContainer
    //-----------------------------------

    function contains(...elements):GroupBuilder;

    function children():ChildrenBuilder;

    //-----------------------------------
    //  Methods: Extra
    //-----------------------------------

    function bindWidthTo(source:Object):GroupBuilder;
    function bindHeightTo(source:Object):GroupBuilder;

    //-----------------------------------
    //  Methods: Group
    //-----------------------------------

    function layout(value:Object):GroupBuilder;

    function gap(value:Object):GroupBuilder;

    function padding(value:Object, side:String = null):GroupBuilder;

    function paddingLeft(value:Object):GroupBuilder;

    function paddingTop(value:Object):GroupBuilder;

    function paddingRight(value:Object):GroupBuilder;

    function paddingBottom(value:Object):GroupBuilder;

    function horizontalAlign(value:Object):GroupBuilder;

    function verticalAlign(value:Object):GroupBuilder;

    function horizontalScrollPolicy(value:Object):GroupBuilder;

    function verticalScrollPolicy(value:Object):GroupBuilder;
}
}
