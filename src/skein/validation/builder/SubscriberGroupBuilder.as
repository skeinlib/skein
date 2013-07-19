/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/17/13
 * Time: 3:46 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.validation.builder
{
public interface SubscriberGroupBuilder
{
    function addSubscriber():SubscriberBuilder;

    function build():Object;
}
}
