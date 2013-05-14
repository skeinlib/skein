/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/25/13
 * Time: 3:57 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.logical
{
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertTrue;

public class NotOperatorTest
{
    public function NotOperatorTest()
    {
    }

    [Test]
    public function getValue():void
    {
        assertTrue(new NotOperator(false).getValue());
        assertFalse(new NotOperator(true).getValue());

        assertTrue(new NotOperator(null).getValue());
        assertTrue(new NotOperator("").getValue());
        assertTrue(new NotOperator(0).getValue());
        assertTrue(new NotOperator(NaN).getValue());

        assertFalse(new NotOperator({}).getValue());
        assertFalse(new NotOperator("Hello").getValue());
        assertFalse(new NotOperator(1).getValue());
    }
}
}
