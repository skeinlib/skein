package skein.binding
{
import skein.binding.operators.comparison.LessOperator;

public function lt(operand1:Object, operand2:Object):LessOperator
{
    return new LessOperator(operand1, operand2);
}
}