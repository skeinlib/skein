/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/19/13
 * Time: 4:07 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.popups.builder
{
import skein.popups.PopupWrapper;

public interface PopupWrapperBuilder
{
    function open(value:Object):PopupWrapperBuilder;

    function modal(value:Object):PopupWrapperBuilder;

    function position(value:Object):PopupWrapperBuilder;

    function center(value:Object):PopupWrapperBuilder;

    function reuse(value:Object):PopupWrapperBuilder;

    function popup(value:Object):PopupWrapperBuilder;

    function onOpening(handler:Function, weak:Boolean = false):PopupWrapperBuilder;

    function onOpened(handler:Function, weak:Boolean = false):PopupWrapperBuilder;

    function onClosing(handler:Function, weak:Boolean = false):PopupWrapperBuilder;

    function onClosed(handler:Function, weak:Boolean = false):PopupWrapperBuilder;

    function build():PopupWrapper;
}
}
