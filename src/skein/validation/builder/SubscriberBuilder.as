/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/17/13
 * Time: 3:47 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.validation.builder
{
public interface SubscriberBuilder
{
    function validator(value:Object):SubscriberBuilder;

    function listener(value:Object):SubscriberBuilder;

    function build():SubscriberGroupBuilder;
}
}
