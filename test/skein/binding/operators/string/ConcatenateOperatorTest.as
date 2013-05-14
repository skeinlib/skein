/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/25/13
 * Time: 3:52 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.string
{
public class ConcatenateOperatorTest
{
    public function ConcatenateOperatorTest()
    {
    }

    [Test]
    public function getValue():void
    {
        var operator:ConcatenateOperator = new ConcatenateOperator(["A", "B", "C", "D"]);

        assertEquals("ABCD", operator.getValue());
    }
}
}
