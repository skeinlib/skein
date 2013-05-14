/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/30/13
 * Time: 12:43 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.comparison
{
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertTrue;

public class GreaterOrEqualOperatorTest
{
    public function GreaterOrEqualOperatorTest()
    {
    }

    [Test]
    public function getValue():void
    {
        assertTrue(new GreaterOrEqualOperator(2, 2).getValue());
        assertFalse(new GreaterOrEqualOperator(2, 4).getValue());
    }
}
}
