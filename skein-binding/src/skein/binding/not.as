package skein.binding
{
import skein.binding.core.Operator;
import skein.binding.operators.logical.NotOperator;

public function not(operand:Object):Operator
{
    return new NotOperator(operand);
}
}