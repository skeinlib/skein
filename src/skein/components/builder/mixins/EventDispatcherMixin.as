/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/20/13
 * Time: 11:35 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.mixins
{
public interface EventDispatcherMixin
{
    function on(event:String, handler:Function, weak:Boolean):void;
}
}
