/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/21/13
 * Time: 1:31 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.core
{
import flash.utils.getTimer;

import skein.core.skein_internal;
import skein.core.Reference;
import skein.core.WeakReference;

use namespace skein_internal;

public class Binding
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Binding(source:Source, destination:Destination)
    {
        super();

        this.destination = destination;
        this.source = new WeakReference(source);
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var destination:Destination;
    public var source:Reference;

    //----------------------------------
    //  Variables: Flags
    //----------------------------------

    private var enabled:Boolean = true;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  Methods: Public API
    //------------------------------------

    public function execute():void
    {
        if (!this.enabled) return;

        var t:Number = getTimer();

        var value:* = this.source.value.getValue();

        // TODO: next add support for nested binding source, but it could lead a memory leak

        if (value is Source)
        {
            Source(value).setCallback(callback);
        }

        this.destination.setValue(value);
    }

    public function enable():void
    {
        this.enabled = true;
    }

    public function disable():void
    {
        this.enabled = false;
    }

    //------------------------------------
    //  Methods: External
    //------------------------------------

    skein_internal function install():void
    {
        var site:Object = this.destination.getSite();

        BindingGlobals.installBinding(this, site);

        this.source.value.setCallback(this.callback);
    }

    skein_internal function remove():void
    {
        this.source.value.setCallback(null);
        this.source = null;

        this.destination = null;

        BindingGlobals.removeBinding(this);
    }

    skein_internal function getDestination():Destination
    {
        return this.destination;
    }

    skein_internal function getSource():Source
    {
        return this.source.value;
    }

    skein_internal function getDestinationMember():String
    {
        return this.destination ? this.destination.getMember() : null;
    }

    skein_internal function isEnabled():Boolean
    {
        return this.enabled;
    }

    //------------------------------------
    //  Methods: Internal
    //------------------------------------


    //------------------------------------
    //  Methods: Callback
    //------------------------------------

    private function callback():void
    {
        this.execute();
    }
}
}
