/**
 * Created by max on 8/20/16.
 */
package skein.binding.operators.misc
{
import skein.binding.core.OperatorBase;

public class IndexOfOperator extends OperatorBase
{
    public function IndexOfOperator(source:Object, search:Object)
    {
        super();

        this.setOperands([source, search]);
    }

    override public function getValue():Object
    {
        var source:Object = OperatorBase.getOperandValue(this.operands[0]);
        var search:Object = OperatorBase.getOperandValue(this.operands[1]);

        if (source is String)
        {
            return String(source).indexOf(search as String);
        }
        else if (source is Array)
        {
            return (source as Array).indexOf(search);
        }
        else
        {
            return null;
        }
    }
}
}
