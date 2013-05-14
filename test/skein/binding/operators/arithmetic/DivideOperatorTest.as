/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/26/13
 * Time: 9:30 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.arithmetic
{
public class DivideOperatorTest
{
    public function DivideOperatorTest()
    {
    }

    [Test]
    public function getValue():void
    {
        assertEquals(0.5, new DivideOperator([2, 2, 2]).getValue());
    }
}
}
