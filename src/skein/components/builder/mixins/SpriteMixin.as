/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 11:23 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.mixins
{
public interface SpriteMixin
{
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-----------------------------------
    //  Methods: DisplayObject
    //-----------------------------------

    function x(value:Object):void;

    function y(value:Object):void;

    function z(value:Object):void;

    function width(value:Object):void;

    function height(value:Object):void;

    function visible(value:Object):void;

    function alpha(value:Object):void;

    function rotation(value:Object, axis:String=null):void;

    function scale(value:Object, axis:String=null):void;

    function mask(value:Object):void;

    //-----------------------------------
    //  Methods: DisplayObjectContainer
    //-----------------------------------

    function contains(...children):void;

    //-----------------------------------
    //  Methods: Sprite
    //-----------------------------------


}
}
