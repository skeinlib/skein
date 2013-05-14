/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/21/13
 * Time: 1:31 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.core
{
import skein.core.skein_internal;

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
        this.source = source;
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var destination:Destination;
    private var source:Source;

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

        var site:Object = BindingGlobals.getBindingSite(this);

        this.destination.setSite(site);

        this.destination.setValue(this.source.getValue());

        this.destination.setSite(null);
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

        this.destination.setSite(null);

        BindingGlobals.installBinding(this, site);

        this.source.setCallback(this.callback);
    }

    skein_internal function remove():void
    {
        this.source.setCallback(null);
        this.source = null;

        BindingGlobals.removeBinding(this);
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




//    //----------------------------------
//    //  Variables: Internal
//    //----------------------------------
//
//    skein_internal var property:String;
//
////    skein_internal var source:Source;
//
//    //--------------------------------------------------------------------------
//    //
//    //  Methods
//    //
//    //--------------------------------------------------------------------------
//
//    public function execute():void
//    {
//        if (!this.enabled)
//            return;
//
//        var site:Object = BindingGlobals.getBindingSite(this);
//
//        if (site)
//        {
//            site[property] = this.source.getValue();
//        }
//    }
//
//    public function enable():void
//    {
//        this.enabled = true;
//    }
//
//    public function disable():void
//    {
//        this.enabled = false;
//    }
//
//    public function remove():void
//    {
//        this.source.setCallback(null);
//        this.source = null;
//
//        BindingGlobals.removeBinding(this);
//    }
//
//    public function dispose():void
//    {
//        BindingGlobals.removeBinding(this);
//
//        source.dispose();
//    }
//
//    private function callback():void
//    {
//        this.execute();
//    }
}
}
