/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/30/13
 * Time: 12:10 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.comparison
{
import skein.binding.core.OperatorBase;

public class GreaterOrEqualOperator extends OperatorBase
{
    public function GreaterOrEqualOperator(operand1:Object, operand2:Object)
    {
        super();

        this.setOperands([operand1, operand2]);
    }

    override public function getValue():Object
    {
        var value1:Object = OperatorBase.getOperandValue(this.operands[0]);
        var value2:Object = OperatorBase.getOperandValue(this.operands[1]);

        return value1 >= value2;
    }
}
}
