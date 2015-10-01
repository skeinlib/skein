/**
 * Created by Max Rozdobudko on 3/5/15.
 */
package skein.binding.operators.misc
{
import skein.binding.core.OperatorBase;

public class StringifyOperator extends OperatorBase
{
    public function StringifyOperator(operand:Object)
    {
        super();

        this.setOperands([operand]);
    }

    override public function getValue():Object
    {
        var value:Object = OperatorBase.getOperandValue(this.operands[0]);

        if (value == null)
        {
            return null;
        }
        else
        {
            return String(value);
        }
    }
}
}