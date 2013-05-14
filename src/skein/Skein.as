/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/20/13
 * Time: 10:48 AM
 * To change this template use File | Settings | File Templates.
 */
package skein
{
import skein.binding.core.BindingGlobals;
import skein.core.skein_internal;
import skein.states.core.StateGlobals;

use namespace skein_internal;

public class Skein
{
    public static function dispose(host:Object):void
    {
        StateGlobals.dispose(host)
        BindingGlobals.dispose(host);
    }
}
}
