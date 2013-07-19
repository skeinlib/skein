/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/19/13
 * Time: 10:53 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.validation.impl.builder
{
import skein.core.PropertySetter;
import skein.validation.Subscriber;
import skein.validation.SubscriberGroup;
import skein.validation.builder.SubscriberBuilder;
import skein.validation.builder.SubscriberGroupBuilder;

public class DefaultSubscriberBuilder implements SubscriberBuilder
{
    public function DefaultSubscriberBuilder(parent:DefaultSubscriberGroupBuilder, group:SubscriberGroup)
    {
        super();

        this.parent = parent;
        this.group = group;
        this.subscriber = new Subscriber();
    }

    private var parent:DefaultSubscriberGroupBuilder;

    private var group:SubscriberGroup;

    private var subscriber:Subscriber;

    public function validator(value:Object):SubscriberBuilder
    {
        PropertySetter.set(this.subscriber, "validator", value);

        return this;
    }

    public function listener(value:Object):SubscriberBuilder
    {
        PropertySetter.set(this.subscriber, "listener", value);

        return this;
    }

    public function build():SubscriberGroupBuilder
    {
        return this.parent;
    }
}
}
