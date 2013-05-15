/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 10:30 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.conditional
{
import skein.binding.core.OperatorBase;

public class ConditionalOperator extends OperatorBase
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function ConditionalOperator(condition:Object)
    {
        super();

        this.temp[0] = condition;
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var temp:Array = [];

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    private function get isAllOperandsDefined():Boolean
    {
        return this.temp[0] != undefined && this.temp[1] != undefined && this.temp[2] != undefined;
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override public function getValue():Object
    {
        if (OperatorBase.getOperandValue(this.operands[0]))
            return OperatorBase.getOperandValue(this.operands[1]);
        else
            return OperatorBase.getOperandValue(this.operands[2]);
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    public function ifTrue(operand:Object):ConditionalOperator
    {
        this.temp[1] = operand;

        if (this.isAllOperandsDefined)
        {
            this.setOperands(this.temp);
            this.temp = null;
        }

        return this;
    }

    public function ifFalse(operand:Object):ConditionalOperator
    {
        this.temp[2] = operand;

        if (this.isAllOperandsDefined)
        {
            this.setOperands(this.temp);
            this.temp = null;
        }

        return this;
    }

}
}
