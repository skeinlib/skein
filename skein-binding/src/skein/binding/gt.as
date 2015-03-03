package skein.binding
{
import skein.binding.operators.comparison.GreaterOperator;

public function gt(operand1:Object, operand2:Object):GreaterOperator
{
    return new GreaterOperator(operand1, operand2);
}
}