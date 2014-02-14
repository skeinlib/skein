/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/25/13
 * Time: 1:34 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.misc
{
import skein.binding.core.OperatorBase;

public class LabelFunctionOperator extends OperatorBase
{
    public function LabelFunctionOperator(operand:Object, labelFunction:Function)
    {
        super();

        this.setOperands([operand]);

        this.labelFunction = labelFunction;
    }

    private var labelFunction:Function;

    override public function getValue():Object
    {
        var value:Object = OperatorBase.getOperandValue(this.operands[0]);

        return labelFunction(value);
    }
}
}
