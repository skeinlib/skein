/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 1:00 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.components
{
import skein.components.builder.Builder;

public interface ListBuilder extends Builder
{
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-----------------------------------
    //  Methods: Object
    //-----------------------------------

    function set(property:String, value:Object):ListBuilder;

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    function on(type:String, handler:Function, weak:Boolean=true):ListBuilder;

    //-----------------------------------
    //  Methods: Sprite
    //-----------------------------------

    function x(value:Object):ListBuilder;

    function y(value:Object):ListBuilder;

    function z(value:Object):ListBuilder;

    function width(value:Object):ListBuilder;

    function height(value:Object):ListBuilder;

    function maxWidth(value:Object):ListBuilder;

    function maxHeight(value:Object):ListBuilder;

    function visible(value:Object):ListBuilder;

    function alpha(value:Object):ListBuilder;

    function rotation(value:Object, axis:String=null):ListBuilder;

    function scale(value:Object, axis:String=null):ListBuilder;

    function mask(value:Object):ListBuilder;

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    function id(id:Object):ListBuilder;

    function styleName(value:Object):ListBuilder;

    function enabled(value:Object):ListBuilder;

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    function left(value:Object):ListBuilder;
    function leftAnchor(value:Object):ListBuilder;

    function top(value:Object):ListBuilder;
    function topAnchor(value:Object):ListBuilder;

    function right(value:Object):ListBuilder;
    function rightAnchor(value:Object):ListBuilder;

    function bottom(value:Object):ListBuilder;
    function bottomAnchor(value:Object):ListBuilder;

    function horizontalCenter(value:Object):ListBuilder;
    function horizontalCenterAnchor(value:Object):ListBuilder;

    function verticalCenter(value:Object):ListBuilder;
    function verticalCenterAnchor(value:Object):ListBuilder;

    function includeInLayout(value:Object):ListBuilder;
    
    //-------------------------------------
    //  Methods: List
    //-------------------------------------
    
    function layout(value:Object):ListBuilder;

    function provider(value:Object):ListBuilder;

    function item(value:Object):ListBuilder;

    function index(value:Object):ListBuilder;

    function selectable(value:Object):ListBuilder;

    function renderer(value:Object):ListBuilder;

    function labelField(value:Object):ListBuilder;

    function labelFunction(value:Object):ListBuilder;
}
}
