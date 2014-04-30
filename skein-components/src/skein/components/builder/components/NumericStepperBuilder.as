/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/16/13
 * Time: 5:59 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.components
{
import skein.components.builder.Builder;

public interface NumericStepperBuilder extends Builder
{
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-----------------------------------
    //  Methods: Object
    //-----------------------------------

    function set(property:String, value:Object):NumericStepperBuilder;

    //-----------------------------------
    //  Methods: EventDispatcher
    //-----------------------------------

    function on(type:String, handler:Function, weak:Boolean=true):NumericStepperBuilder;

    //-----------------------------------
    //  Methods: Sprite
    //-----------------------------------

    function x(value:Object):NumericStepperBuilder;

    function y(value:Object):NumericStepperBuilder;

    function z(value:Object):NumericStepperBuilder;

    function width(value:Object):NumericStepperBuilder;

    function height(value:Object):NumericStepperBuilder;

    function visible(value:Object):NumericStepperBuilder;

    function alpha(value:Object):NumericStepperBuilder;

    function rotation(value:Object, axis:String=null):NumericStepperBuilder;

    function scale(value:Object, axis:String=null):NumericStepperBuilder;

    function mask(value:Object):NumericStepperBuilder;

    //-----------------------------------
    //  Methods: Component
    //-----------------------------------

    function id(id:Object):NumericStepperBuilder;

    function styleName(value:Object):NumericStepperBuilder;

    function enabled(value:Object):NumericStepperBuilder;

    //-----------------------------------
    //  Methods: LayoutElement
    //-----------------------------------

    function left(value:Object):NumericStepperBuilder;

    function top(value:Object):NumericStepperBuilder;

    function right(value:Object):NumericStepperBuilder;

    function bottom(value:Object):NumericStepperBuilder;

    function horizontalCenter(value:Object):NumericStepperBuilder;

    function verticalCenter(value:Object):NumericStepperBuilder;

    //-----------------------------------
    //  Methods: NumericStepper
    //-----------------------------------
    
    function minimum(value:Object):NumericStepperBuilder;

    function maximum(value:Object):NumericStepperBuilder;

    function step(value:Object):NumericStepperBuilder;

    function value(value:Object):NumericStepperBuilder;
}
}
