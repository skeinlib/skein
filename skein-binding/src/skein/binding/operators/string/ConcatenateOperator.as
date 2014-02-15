/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 10:23 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.string
{
import skein.binding.core.OperatorBase;

public class ConcatenateOperator extends OperatorBase
{
    public function ConcatenateOperator(operands:Array)
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

        return result;
    }
}
}
