/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 10:49 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.logical
{
import skein.binding.core.OperatorBase;

public class AndOperator extends OperatorBase
{
    public function AndOperator(operands:Array)
    {
        super();

        this.setOperands(operands);
    }

    override public function getValue():Object
    {
        for each (var operand:Object in this.operands)
        {
            var value:Object = OperatorBase.getOperandValue(operand);

            if (!value) return false;
        }

        return true;
    }
}
}
