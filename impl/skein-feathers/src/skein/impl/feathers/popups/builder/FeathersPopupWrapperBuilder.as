/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/19/13
 * Time: 4:36 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.popups.builder
{
import skein.core.PropertySetter;
import skein.impl.feathers.popups.FeathersPopupWrapper;
import skein.popups.PopupWrapper;
import skein.popups.builder.PopupWrapperBuilder;
import skein.popups.events.PopupEvent;

public class FeathersPopupWrapperBuilder implements PopupWrapperBuilder
{
    public function FeathersPopupWrapperBuilder()
    {
        super();
        
        this.wrapper = new FeathersPopupWrapper();
    }
    
    private var wrapper:FeathersPopupWrapper;

    public function open(value:Object):PopupWrapperBuilder
    {
        PropertySetter.set(wrapper, "open", value);

        return this;
    }

    public function modal(value:Object):PopupWrapperBuilder
    {
        PropertySetter.set(wrapper, "modal", value);

        return this;
    }

    public function position(value:Object):PopupWrapperBuilder
    {
        PropertySetter.set(wrapper, "position", value);

        return this;
    }

    public function reuse(value:Object):PopupWrapperBuilder
    {
        PropertySetter.set(wrapper, "reuse", value);

        return this;
    }

    public function popup(value):PopupWrapperBuilder
    {
        PropertySetter.set(wrapper, "popup", value);

        return this;
    }

    public function onOpening(handler:Function, weak:Boolean):PopupWrapperBuilder
    {
        wrapper.addEventListener(PopupEvent.OPENING, handler, false, 0, weak);

        return this;
    }

    public function onOpened(handler:Function, weak:Boolean):PopupWrapperBuilder
    {
        wrapper.addEventListener(PopupEvent.OPENED, handler, false, 0, weak);

        return this;
    }

    public function onClosing(handler:Function, weak:Boolean):PopupWrapperBuilder
    {
        wrapper.addEventListener(PopupEvent.CLOSING, handler, false, 0, weak);

        return this;
    }

    public function onClosed(handler:Function, weak:Boolean):PopupWrapperBuilder
    {
        wrapper.addEventListener(PopupEvent.CLOSED, handler, false, 0, weak);

        return this;
    }

    public function build():PopupWrapper
    {
        return wrapper;
    }
}
}
