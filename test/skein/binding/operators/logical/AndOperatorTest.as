/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/25/13
 * Time: 3:54 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.logical
{
public class AndOperatorTest
{
    public function AndOperatorTest()
    {
    }

    [Test]
    public function getValue():void
    {
        assertTrue(new AndOperator(["Hello", true, 1]).getValue());

        assertFalse(new AndOperator(["Hello", true, 0]).getValue());
        assertFalse(new AndOperator(["Hello", false, 1]).getValue());
        assertFalse(new AndOperator(["", true, 1]).getValue());
    }
}
}
