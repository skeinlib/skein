/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/15/13
 * Time: 12:23 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.operators.conditional
{
import skein.binding.core.OperatorBase;

public class SwitchOperator extends OperatorBase
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function SwitchOperator(control:Object)
    {
        super();

        this.setOperands([control]);
    }

    //---------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var statements:Object = {};

    private var defaultValue:Object;

    //---------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override public function getValue():Object
    {
        var value:Object = OperatorBase.getOperandValue(this.operands[0]);

        if (value in statements)
            return OperatorBase.getOperandValue(statements[value].value);

        if (defaultValue !== undefined)
            return OperatorBase.getOperandValue(defaultValue);

        return null;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function inCase(...values):CaseBlock
    {
        var statement:Statement = new Statement();

        for each (var value:Object in values)
        {
            this.statements[value] = statement;
        }

        return new CaseBlock(this, statement);
    }

    public function byDefault(value:Object):SwitchOperator
    {
        this.defaultValue = value;

        return this;
    }
}
}

import skein.binding.operators.conditional.SwitchOperator;

class CaseBlock
{
    public function CaseBlock(operator:SwitchOperator, statement:Statement)
    {
        super();

        this.operator = operator;
        this.statement = statement;
    }

    private var operator:SwitchOperator;

    private var statement:Statement;

    public function yield(operand:Object):SwitchOperator
    {
        this.statement.value = operand;

        return this.operator;
    }

}

class Statement
{
    public var value:Object;
}