/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/26/13
 * Time: 9:36 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.arithmetic
{
public class MultiplyOperatorTest
{
    public function MultiplyOperatorTest()
    {
    }

    [Test]
    public function getValue():void
    {
        assertEquals(8, new MultiplyOperator([2, 2, 2]).getValue());
    }
}
}
