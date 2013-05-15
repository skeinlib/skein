/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/30/13
 * Time: 12:12 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.comparison
{
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertTrue;

public class EqualOperatorTest
{
    public function EqualOperatorTest()
    {
    }

    [Test]
    public function getValue():void
    {
        assertTrue(new EqualOperator([2, 2, 2]).getValue());
        assertFalse(new EqualOperator([2, 2, 3]).getValue());

        assertTrue(new EqualOperator([true, 1]).getValue());
        assertTrue(new EqualOperator([false, ""]).getValue());
    }
}
}
