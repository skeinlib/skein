/**
 * Created by max on 8/18/16.
 */
package skein.binding.operators.string
{
import skein.binding.core.OperatorBase;

public class LowerCaseOperator extends OperatorBase
{
    public function LowerCaseOperator(operands:Array)
    {
        super();

        this.setOperands(operands);
    }

    override public function getValue():Object
    {
        var result:String = "";

        for each (var operand:Object in this.operands)
        {
            var value:Object = OperatorBase.getOperandValue(operand);

            result += value;
        }

        return result.toLowerCase();
    }
}
}
