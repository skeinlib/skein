/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/30/13
 * Time: 12:06 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.comparison
{
import skein.binding.core.OperatorBase;

public class EqualOperator extends OperatorBase
{
    public function EqualOperator(operands:Array)
    {
        super();

        this.setOperands(operands);
    }

    override public function getValue():Object
    {
        var value:Object;

        for (var i:int = 0, n:int = this.operands.length; i < n; i++)
        {
            var operand:Object = this.operands[i];

            if (i == 0)
            {
                value = OperatorBase.getOperandValue(operand);
                continue;
            }

            if (value == OperatorBase.getOperandValue(operand))
            {
                continue;
            }
            else
            {
                return false;
            }
        }

        return true;
    }
}
}
