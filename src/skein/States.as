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

import skein.states.StateHolder;

public class States
{
    private static var factory:Class;

    public static function setFactory(value:Class):void
    {
        factory = value;
    }

    private static var holders:Dictionary;

    public static function host(host:Object):StateHolder
    {
        if (!holders)
            holders = new Dictionary(true);

        return new factory(host);
//        return holders[host] || (holders[host] = new FeathersStateHolder(host));
    }
}
}
