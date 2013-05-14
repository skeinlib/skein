/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/10/13
 * Time: 2:23 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.core
{
import flash.utils.Dictionary;

import skein.core.skein_internal;

use namespace skein_internal;

public class ComponentsGlobals
{
    private static var handlers:Dictionary;

    skein_internal static function bindWidth(source:Object, target:Object):void
    {
        const handler:Function = function (event:Object):void
        {
            target.width = source.width;
        }

        source.addEventListener("resize", handler);
    }

    skein_internal static function bindHeight(source:Object, target:Object):void
    {
        const handler:Function = function (event:Object):void
        {
            target.height = source.height;
        }

        source.addEventListener("resize", handler);
    }
}
}
