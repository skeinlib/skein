/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/24/13
 * Time: 11:19 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.states.overrides
{
import skein.binding.core.Binding;
import skein.binding.core.BindingGlobals;
import skein.core.PropertySetter;
import skein.core.skein_internal;
import skein.states.Override;

use namespace skein_internal;

public class SetProperty extends OverrideBase implements Override
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    // TODO: Enable nested property some like "loginForm.registerButton.layout" it's a requirement for support Feather's layout properties.
    public function SetProperty(property:String, member:String, value:Object)
    {
        super(property, member, value);
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var oldValue:Object;

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override public function apply(host:Object):void
    {
        var context:Object = this.getContext(host);

        if (!this.applied)
        {
            var binding:Binding = BindingGlobals.getBinding(context, this.name);

            if (binding)
            {
                binding.disable();

                this.oldValue = binding;
            }
            else
            {
                this.oldValue = context[this.name];
            }
        }

        PropertySetter.set(context, this.name, this._value);

        this.applied = true;
    }

    override public function remove(host:Object):void
    {
        var context:Object = this.getContext(host);

        if (this.applied)
        {
            var binding:Binding = BindingGlobals.getBinding(context, this.name);

            if (binding)
                binding.remove();

            if (this.oldValue is Binding)
            {
                Binding(this.oldValue).enable();
            }
            else
            {
                context[this.name] = this.oldValue;
            }
        }

        this.applied = false;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

}
}
