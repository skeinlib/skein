/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/15/13
 * Time: 12:35 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.conditional
{
import org.flexunit.asserts.assertEquals;

public class SwitchOperatorTest
{
    public function SwitchOperatorTest()
    {
    }

    [Test]
    public function inDefault():void
    {
        assertEquals(0, new SwitchOperator(4).inCase(1).yield(100).inCase(2).yield(200).inCase(3).yield(300).byDefault(0).getValue())
    }

    [Test]
    public function inCase():void
    {
        assertEquals(100, new SwitchOperator(1).inCase(1).yield(100).inCase(2).yield(200).inCase(3).yield(300).byDefault(0).getValue());
        assertEquals(200, new SwitchOperator(2).inCase(1).yield(100).inCase(2).yield(200).inCase(3).yield(300).byDefault(0).getValue());
        assertEquals(300, new SwitchOperator(3).inCase(1).yield(100).inCase(2).yield(200).inCase(3).yield(300).byDefault(0).getValue());

        assertEquals(100, new SwitchOperator(1).inCase(1, 2, 3).yield(100).byDefault(0).getValue());
        assertEquals(100, new SwitchOperator(2).inCase(1, 2, 3).yield(100).byDefault(0).getValue());
        assertEquals(100, new SwitchOperator(3).inCase(1, 2, 3).yield(100).byDefault(0).getValue());
    }
}
}
