/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/26/13
 * Time: 9:05 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.arithmetic
{
import skein.binding.core.OperatorBase;

public class AddOperator extends OperatorBase
{
    public function AddOperator(operands:Array)
    {
        super();

        this.setOperands(operands);
    }

    override public function getValue():Object
    {
        var result:Number = 0;

        for each (var operand:Object in this.operands)
        {
            result += Number(OperatorBase.getOperandValue(operand));
        }

        return result;
    }
}
}
