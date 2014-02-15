/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/17/13
 * Time: 3:46 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.validators.builder
{
import skein.validators.SubscriberGroup;

public interface SubscriberGroupBuilder
{
    function addSubscriber():SubscriberBuilder;

    function build():SubscriberGroup;
}
}
