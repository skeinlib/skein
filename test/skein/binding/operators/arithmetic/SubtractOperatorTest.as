/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/26/13
 * Time: 9:40 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.arithmetic
{
public class SubtractOperatorTest
{
    public function SubtractOperatorTest()
    {
    }

    [Test]
    public function getValue():void
    {
        assertEquals(-2, new SubtractOperator([2, 2, 2]).getValue());
    }
}
}
