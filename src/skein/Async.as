/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/15/13
 * Time: 10:50 PM
 * To change this template use File | Settings | File Templates.
 */
package skein
{
import skein.async.builder.QueueBuilder;
import skein.async.impl.builder.QueueBuilderImpl;

public class Async
{
    public static function queue():QueueBuilder
    {
        return new QueueBuilderImpl();
    }

}
}
