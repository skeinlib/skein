/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/16/13
 * Time: 6:15 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.components
{
import skein.components.builder.*;

public interface PickerBuilder extends Builder
{
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-----------------------------------
    //  Methods: Object
    //-----------------------------------

    function set(property:String, value:Object):PickerBuilder;

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    function on(type:String, handler:Function, weak:Boolean=true):PickerBuilder;

    //-----------------------------------
    //  Methods: Sprite
    //-----------------------------------

    function x(value:Object):PickerBuilder;

    function y(value:Object):PickerBuilder;

    function z(value:Object):PickerBuilder;

    function width(value:Object):PickerBuilder;

    function height(value:Object):PickerBuilder;

    function visible(value:Object):PickerBuilder;

    function alpha(value:Object):PickerBuilder;

    function rotation(value:Object, axis:String=null):PickerBuilder;

    function scale(value:Object, axis:String=null):PickerBuilder;

    function mask(value:Object):PickerBuilder;

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    function id(id:Object):PickerBuilder;

    function styleName(value:Object):PickerBuilder;

    function enabled(value:Object):PickerBuilder;

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    function left(value:Object):PickerBuilder;

    function top(value:Object):PickerBuilder;

    function right(value:Object):PickerBuilder;

    function bottom(value:Object):PickerBuilder;

    function horizontalCenter(value:Object):PickerBuilder;

    function verticalCenter(value:Object):PickerBuilder;

    //-----------------------------------
    //  Methods: List
    //-----------------------------------

    function provider(value:Object):PickerBuilder;

    function item(value:Object):PickerBuilder;

    function typicalItem(value:Object):PickerBuilder;

    function index(value:Object):PickerBuilder;

    function renderer(value:Object):PickerBuilder;

    function labelField(value:Object):PickerBuilder;

    function labelFunction(value:Object):PickerBuilder;

    //-----------------------------------
    //  Methods: PickerList
    //-----------------------------------

    function prompt(value:Object):PickerBuilder;

    function popupManager(value:Object):PickerBuilder;
}
}
