/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/22/13
 * Time: 11:26 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.core
{
public class OperatorBase implements Operator
{
    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    public static function getOperandValue(operand:Object):Object
    {
        if (operand is Operator)
            return operand.getValue();
        else if (operand is Source)
            return Source(operand).getValue();
        else
            return operand;
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function OperatorBase()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Setters
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  callback
    //------------------------------------

    protected var callback:Function;

    public function setCallback(value:Function):void
    {
        this.callback = value;
    }

    //------------------------------------
    //  operands
    //------------------------------------

    protected var operands:Array;

    public function setOperands(value:Array):void
    {
        this.operands = value;

        for each (var operand:Object in this.operands)
        {
            this.setOperand(operand);
        }
    }

    protected function setOperand(operand:Object):void
    {
        if (operand is Source)
            Source(operand).setCallback(handler);
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function getValue():Object
    {
        return null;
    }

    public function dispose():void
    {
        for each (var operand:Object in this.operands)
        {
            if (operand is Source)
                Source(operand).dispose();
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Getters
    //
    //--------------------------------------------------------------------------


    public function handler():void
    {
        if (this.callback)
        {
            switch (this.callback.length)
            {
                case 0 : this.callback(); break;
                case 1 : this.callback(getValue()); break;
            }
        }
    }

//    public function addOperand(operand:Object):void
//    {
//        if (operand is Source)
//        {
//            Source(operand).setCallback(handler);
//        }
//        else
//        {
//            handler();
//        }
//    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

}
}
