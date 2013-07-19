/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/17/13
 * Time: 3:29 PM
 * To change this template use File | Settings | File Templates.
 */
package skein
{
import skein.validation.builder.SubscriberGroupBuilder;
import skein.validation.impl.builder.DefaultSubscriberGroupBuilder;

public class Validators
{
    private static var factory:Class = DefaultSubscriberGroupBuilder;

    public static function setSubscriberGroupFactory(value:Class):void
    {
        factory = value;
    }

    public static function newSubscriberGroup():SubscriberGroupBuilder
    {
        return new factory();
    }
}
}
