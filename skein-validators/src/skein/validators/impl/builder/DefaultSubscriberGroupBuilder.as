/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/19/13
 * Time: 10:52 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.validators.impl.builder
{
import skein.validators.SubscriberGroup;
import skein.validators.builder.SubscriberBuilder;
import skein.validators.builder.SubscriberGroupBuilder;

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

    public function build():SubscriberGroup
    {
        this.group.init();

        return this.group;
    }
}
}
