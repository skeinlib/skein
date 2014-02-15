/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/29/13
 * Time: 4:29 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.core
{
import flash.utils.Dictionary;

import skein.core.skein_internal;

use namespace skein_internal;

public class BindingGlobals
{
    //--------------------------------------------------------------------------
    //
    //  Class variables
    //
    //--------------------------------------------------------------------------

    private static var bindings:Dictionary;

    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    skein_internal static function installBinding(binding:Binding, site:Object):void
    {
        if (!bindings)
            bindings = new Dictionary(true);

        if (!bindings[site])
            bindings[site] = {};

        var member:String = binding.getDestinationMember();

        var installed:Array = bindings[site][member] || (bindings[site][member] = []);

//        for each (var b:Binding in installed)
//        {
//            if (b.isEnabled())
//            {
//                trace("Warning: Binding has been forcibly disabled, site='"+ site +"', member='"+ member +"'");
//
//                b.disable();
//            }
//        }

        installed.push(binding);
    }

    skein_internal static function removeBinding(binding:Binding):void
    {
        if (!bindings) return;

        var member:String = binding.getDestinationMember();

        for (var site:* in bindings)
        {
            if (member in bindings[site])
            {
                var installed:Array = bindings[site][member];

                var index:int = installed.indexOf(binding);

                if (index != -1)
                {
                    installed.splice(index, 1);
                    return;
                }
            }
        }
    }

    skein_internal static function getBinding(site:Object, property:String):Binding
    {
        if (!bindings || !bindings[site] || !bindings[site][property])
            return null;

        var installed:Array = bindings[site][property];

        for each (var b:Binding in installed)
        {
            if (b.isEnabled())
                return b;
        }

        return null;
    }

    [Deprecated]
    skein_internal static function getBindingSite(binding:Binding):Object
    {
        var member:String = binding.getDestinationMember();

        for (var site:* in bindings)
        {
            if (member in bindings[site])
            {
                var installed:Array = bindings[site][member];

                var index:int = installed.indexOf(binding);

                if (index != -1)
                    return site;
            }
        }

        return null;
    }

    skein_internal static function dispose(host:Object):void
    {
         // does nothing yet
    }

    skein_internal static function getBindings():Array
    {
        var result:Array = [];

        if (!bindings)
            return result;

        for each (var b:Object in bindings)
        {
            for each (var installed:Array in b)
            {
                result = result.concat(installed);
            }
        }

        return result;
    }
}
}
