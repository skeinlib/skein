/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/22/13
 * Time: 12:49 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.logical
{
import skein.binding.core.OperatorBase;

public class OrOperator extends OperatorBase
{
    public function OrOperator(operands:Array)
    {
        super();

        this.setOperands(operands);
    }

    override public function getValue():Object
    {
        var value:Object = null;

        for (var i:uint = 0, n:uint = operands ? operands.length : 0; i < n; i++)
        {
            var operand:Object = operands[i];

            value = OperatorBase.getOperandValue(operand);

            if (value) return value;
        }

        return value;
    }
}
}
