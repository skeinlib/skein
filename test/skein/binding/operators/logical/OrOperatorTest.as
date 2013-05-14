/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/25/13
 * Time: 4:00 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.logical
{
public class OrOperatorTest
{
    public function OrOperatorTest()
    {
    }

    [Test]
    public function getValue():void
    {
        assertEquals("A", new OrOperator([false, null, "A"]).getValue());
    }
}
}
