/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/8/13
 * Time: 2:38 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.components
{
import skein.components.builder.Builder;

public interface ImageBuilder extends Builder
{
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-----------------------------------
    //  Methods: Object
    //-----------------------------------

    function set(property:String, value:Object):ImageBuilder;

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    function on(type:String, handler:Function, weak:Boolean=true):ImageBuilder;

    //-----------------------------------
    //  Methods: Sprite
    //-----------------------------------

    function x(value:Object):ImageBuilder;

    function y(value:Object):ImageBuilder;

    function z(value:Object):ImageBuilder;

    function width(value:Object):ImageBuilder;

    function height(value:Object):ImageBuilder;

    function maxWidth(value:Object):ImageBuilder;

    function maxHeight(value:Object):ImageBuilder;

    function visible(value:Object):ImageBuilder;

    function alpha(value:Object):ImageBuilder;

    function rotation(value:Object, axis:String=null):ImageBuilder;

    function scale(value:Object, axis:String=null):ImageBuilder;

    function mask(value:Object):ImageBuilder;

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    function id(id:Object):ImageBuilder;

    function styleName(value:Object):ImageBuilder;

    function enabled(value:Object):ImageBuilder;

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    function left(value:Object):ImageBuilder;
    function leftAnchor(value:Object):ImageBuilder;

    function top(value:Object):ImageBuilder;
    function topAnchor(value:Object):ImageBuilder;

    function right(value:Object):ImageBuilder;
    function rightAnchor(value:Object):ImageBuilder;

    function bottom(value:Object):ImageBuilder;
    function bottomAnchor(value:Object):ImageBuilder;

    function horizontalCenter(value:Object):ImageBuilder;

    function verticalCenter(value:Object):ImageBuilder;

    function includeInLayout(value:Object):ImageBuilder;

    //-----------------------------------
    //  Methods: Image
    //-----------------------------------

    function source(value:Object):ImageBuilder;

    function smooth(value:Object):ImageBuilder;

    function fillMode(value:Object):ImageBuilder;

    function scaleMode(value:Object):ImageBuilder;
}
}
