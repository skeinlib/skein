/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/19/13
 * Time: 10:52 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.validation.impl.builder
{
import skein.validation.SubscriberGroup;
import skein.validation.builder.SubscriberBuilder;
import skein.validation.builder.SubscriberGroupBuilder;

public class DefaultSubscriberGroupBuilder implements SubscriberGroupBuilder
{
    public function DefaultSubscriberGroupBuilder()
    {
        super();

        this.group = new SubscriberGroup();
    }

    private var group:SubscriberGroup;

    public function addSubscriber():SubscriberBuilder
    {
        return new DefaultSubscriberBuilder(this, this.group);
    }

    public function build():Object
    {
        return this.group;
    }
}
}
