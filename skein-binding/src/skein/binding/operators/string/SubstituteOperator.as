/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 10:25 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.string
{
import skein.binding.core.OperatorBase;

public class SubstituteOperator extends OperatorBase
{
    public static function substitute(str:String, args:Array):String
    {
        if (str == null) return '';

        for (var i:int = 0, n:int = args.length; i < n; i++)
        {
            str = str.replace(new RegExp("\\{"+i+"\\}", "g"), args[i]);
        }

        return str;
    }

    public function SubstituteOperator(pattern:String, operands:Array)
    {
        super();

        this.pattern = pattern;

        this.setOperands(operands);
    }

    private var pattern:String;


    override public function getValue():Object
    {
        var values:Array = [];

        for each (var operand:Object in this.operands)
        {
            values.push(OperatorBase.getOperandValue(operand));
        }

        return substitute(this.pattern, values);
    }
}
}
