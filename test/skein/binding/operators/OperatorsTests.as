/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/25/13
 * Time: 3:42 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators
{
import skein.binding.operators.arithmetic.AddOperatorTest;
import skein.binding.operators.arithmetic.DivideOperatorTest;
import skein.binding.operators.arithmetic.MultiplyOperatorTest;
import skein.binding.operators.arithmetic.SubtractOperatorTest;
import skein.binding.operators.comparison.EqualOperatorTest;
import skein.binding.operators.comparison.GreaterOperatorTest;
import skein.binding.operators.conditional.ConditionalOperatorTest;
import skein.binding.operators.conditional.SwitchOperatorTest;
import skein.binding.operators.logical.AndOperatorTest;
import skein.binding.operators.logical.NotOperatorTest;
import skein.binding.operators.logical.OrOperatorTest;
import skein.binding.operators.string.ConcatenateOperatorTest;
import skein.binding.operators.string.SubstituteOperatorTest;

[Suite]
[RunWith("org.flexunit.runners.Suite")]
public class OperatorsTests
{
    public var add:AddOperatorTest;
    public var subtract:SubtractOperatorTest;
    public var multiply:MultiplyOperatorTest;
    public var divide:DivideOperatorTest;

    public var conditional:ConditionalOperatorTest;
    public var inspect:SwitchOperatorTest;

    public var and:AndOperatorTest;
    public var or:OrOperatorTest;
    public var not:NotOperatorTest;

    public var concatenate:ConcatenateOperatorTest;
    public var substitute:SubstituteOperatorTest;

    public var equal:EqualOperatorTest;
    public var greater:GreaterOperatorTest;
}
}
