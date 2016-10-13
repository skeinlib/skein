/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/30/13
 * Time: 1:46 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.components
{
import skein.components.builder.Builder;

public interface TextBuilder extends Builder
{

    //-----------------------------------
    //  Methods: Object
    //-----------------------------------

    function set(property:String, value:Object):TextBuilder;

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    function on(type:String, handler:Function, weak:Boolean=true):TextBuilder;

    //-----------------------------------
    //  Methods: Sprite
    //-----------------------------------

    function x(value:Object):TextBuilder;

    function y(value:Object):TextBuilder;

    function z(value:Object):TextBuilder;

    function width(value:Object):TextBuilder;

    function height(value:Object):TextBuilder;

    function visible(value:Object):TextBuilder;

    function alpha(value:Object):TextBuilder;

    function rotation(value:Object, axis:String=null):TextBuilder;

    function scale(value:Object, axis:String=null):TextBuilder;

    function mask(value:Object):TextBuilder;

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    function id(id:Object):TextBuilder;

    function styleName(value:Object):TextBuilder;

    function enabled(value:Object):TextBuilder;

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    function left(value:Object):TextBuilder;
    function leftAnchor(value:Object):TextBuilder;

    function top(value:Object):TextBuilder;
    function topAnchor(value:Object):TextBuilder;

    function right(value:Object):TextBuilder;
    function rightAnchor(value:Object):TextBuilder;

    function bottom(value:Object):TextBuilder;
    function bottomAnchor(value:Object):TextBuilder;

    function horizontalCenter(value:Object):TextBuilder;
    function horizontalCenterAnchor(value:Object):TextBuilder;

    function verticalCenter(value:Object):TextBuilder;
    function verticalCenterAnchor(value:Object):TextBuilder;

    //-----------------------------------
    //  Methods: Text
    //-----------------------------------

    function padding(value:Object):TextBuilder;

    function paddingLeft(value:Object):TextBuilder;

    function paddingTop(value:Object):TextBuilder;

    function paddingRight(value:Object):TextBuilder;

    function paddingBottom(value:Object):TextBuilder;

    function border(value:Object):TextBuilder;

    function borderColor(value:Object):TextBuilder;

    function isHTML(value:Object):TextBuilder;

    function condenseWhite(value:Object):TextBuilder;

    function displayAsPassword(value:Object):TextBuilder;

    function gridFitType(value:Object):TextBuilder;

    function sharpness(value:Object):TextBuilder;

    function thickness(value:Object):TextBuilder;

    function text(value:Object):TextBuilder;

    function styleSheet(value:Object):TextBuilder;
}
}
