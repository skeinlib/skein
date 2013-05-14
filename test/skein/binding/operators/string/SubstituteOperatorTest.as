/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/25/13
 * Time: 3:34 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.string
{
import org.flexunit.asserts.assertEquals;

public class SubstituteOperatorTest
{
    public function SubstituteOperatorTest()
    {
    }

    [Test]
    public function getValue():void
    {
        var operator:SubstituteOperator = new SubstituteOperator("{0} - {1} - {2}", ["A", "B", "C"]);

        assertEquals("A - B - C", operator.getValue());
    }
}
}
