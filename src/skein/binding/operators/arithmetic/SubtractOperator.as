/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/26/13
 * Time: 9:06 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.arithmetic
{
import skein.binding.core.OperatorBase;

public class SubtractOperator extends OperatorBase
{
    public function SubtractOperator(operands:Array)
    {
        super();

        this.setOperands(operands);
    }

    override public function getValue():Object
    {
        var result:Number = NaN;

        for (var i:uint = 0, n:uint = this.operands.length; i < n; i++)
        {
            var operand:Object = this.operands[i];

            if (i == 0)
            {
                result = Number(OperatorBase.getOperandValue(operand));
            }
            else
            {
                result -= Number(OperatorBase.getOperandValue(operand));
            }
        }

        return result;
    }
}
}
