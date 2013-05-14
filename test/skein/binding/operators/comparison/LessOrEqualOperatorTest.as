/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/30/13
 * Time: 12:45 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.comparison
{
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertTrue;

public class LessOrEqualOperatorTest
{
    public function LessOrEqualOperatorTest()
    {
    }

    [Test]
    public function getValue():void
    {
        assertTrue(new LessOperator(2, 4).getValue());
        assertTrue(new LessOperator(4, 4).getValue());
        assertFalse(new LessOperator(4, 2).getValue());
    }
}
}
