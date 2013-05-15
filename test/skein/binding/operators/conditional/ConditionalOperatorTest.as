/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/26/13
 * Time: 9:59 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.conditional
{
import org.flexunit.asserts.assertEquals;

public class ConditionalOperatorTest
{
    public function ConditionalOperatorTest()
    {
    }

    [Test]
    public function getValue():void
    {
        assertEquals(1, new ConditionalOperator(true).ifTrue(1).ifFalse(2).getValue());
        assertEquals(2, new ConditionalOperator(false).ifTrue(1).ifFalse(2).getValue());
    }
}
}
