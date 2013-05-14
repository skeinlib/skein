/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/26/13
 * Time: 9:28 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.arithmetic
{
import org.flexunit.asserts.assertEquals;

public class AddOperatorTest
{
    public function AddOperatorTest()
    {
    }

    [Test]
    public function getValue():void
    {
        assertEquals(4, new AddOperator([2, 2]).getValue());
        assertEquals(6, new AddOperator([2, 2, 2]).getValue());
    }
}
}
