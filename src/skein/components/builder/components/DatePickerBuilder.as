/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/26/13
 * Time: 1:58 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.components
{
import skein.components.builder.Builder;

public interface DatePickerBuilder extends Builder
{
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    function on(type:String, handler:Function, weak:Boolean=true):DatePickerBuilder;

    //-----------------------------------
    //  Methods: Sprite
    //-----------------------------------

    function x(value:Object):DatePickerBuilder;

    function y(value:Object):DatePickerBuilder;

    function z(value:Object):DatePickerBuilder;

    function width(value:Object):DatePickerBuilder;

    function height(value:Object):DatePickerBuilder;

    function visible(value:Object):DatePickerBuilder;

    function alpha(value:Object):DatePickerBuilder;

    function rotation(value:Object, axis:String=null):DatePickerBuilder;

    function scale(value:Object, axis:String=null):DatePickerBuilder;

    function mask(value:Object):DatePickerBuilder;

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    function id(id:Object):DatePickerBuilder;

    function styleName(value:Object):DatePickerBuilder;

    function enabled(value:Object):DatePickerBuilder;

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    function left(value:Object):DatePickerBuilder;

    function top(value:Object):DatePickerBuilder;

    function right(value:Object):DatePickerBuilder;

    function bottom(value:Object):DatePickerBuilder;

    function horizontalCenter(value:Object):DatePickerBuilder;

    function verticalCenter(value:Object):DatePickerBuilder;

    //-----------------------------------
    //  Methods: List
    //-----------------------------------

    function provider(value:Object):DatePickerBuilder;

    function item(value:Object):DatePickerBuilder;

    function typicalItem(value:Object):DatePickerBuilder;

    function index(value:Object):DatePickerBuilder;

    function renderer(value:Object):DatePickerBuilder;

    function labelField(value:Object):DatePickerBuilder;

    function labelFunction(value:Object):DatePickerBuilder;

    //-----------------------------------
    //  Methods: DatePicker
    //-----------------------------------

    function date(value:Object):DatePickerBuilder;

    function title(value:Object):DatePickerBuilder;

    function message(value:Object):DatePickerBuilder;
}
}
