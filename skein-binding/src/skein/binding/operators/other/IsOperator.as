/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/24/13
 * Time: 4:51 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.other
{
import skein.binding.core.OperatorBase;

public class IsOperator extends OperatorBase
{
    public function IsOperator(operand1:Object, operand2:Object)
    {
        super();

        this.setOperands([operand1, operand2]);
    }

    override public function getValue():Object
    {
        var value1:Object = OperatorBase.getOperandValue(this.operands[0]);
        var value2:Class = OperatorBase.getOperandValue(this.operands[1]) as Class;

        return value1 is value2;
    }
}
}
