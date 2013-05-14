/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 5:07 PM
 * To change this template use File | Settings | File Templates.
 */
package skein
{
import flash.utils.Dictionary;

import skein.impl.feathers.states.FeathersStateHolder;
import skein.states.StateHolder;

public class States
{
    private static var holders:Dictionary;

    public static function host(host:Object):StateHolder
    {
        if (!holders)
            holders = new Dictionary(true);

        return new FeathersStateHolder(host);
//        return holders[host] || (holders[host] = new FeathersStateHolder(host));
    }
}
}
