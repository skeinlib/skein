/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/30/13
 * Time: 12:27 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.comparison
{
public class GreaterOperatorTest
{
    public function GreaterOperatorTest()
    {
    }

    [Test]
    public function getValue():void
    {
        assertTrue(new GreaterOperator(4, 2).getValue());
        assertFalse(new GreaterOperator(4, 4).getValue());
    }
}
}
