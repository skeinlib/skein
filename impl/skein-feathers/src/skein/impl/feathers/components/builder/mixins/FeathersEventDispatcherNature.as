/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 12:20 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.mixins
{
import skein.components.builder.mixins.EventDispatcherMixin;

import starling.events.EventDispatcher;

public class FeathersEventDispatcherNature implements EventDispatcherMixin
{
    public function FeathersEventDispatcherNature(instance:EventDispatcher)
    {
        super();

        this.instance = instance;
    }

    private var instance:EventDispatcher;

    public function on(event:String, handler:Function, weak:Boolean):void
    {
        this.instance.addEventListener(event, handler);
    }
}
}
