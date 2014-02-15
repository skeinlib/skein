/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/22/13
 * Time: 10:19 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.logical
{
import skein.binding.core.OperatorBase;

public class NotOperator extends OperatorBase
{
    public function NotOperator(operand:Object)
    {
        super();

        this.setOperands([operand]);
    }

    override public function getValue():Object
    {
        var value:Object = OperatorBase.getOperandValue(this.operands[0]);

        return !value;
    }
}
}
