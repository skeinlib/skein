package skein.binding
{
import skein.binding.operators.arithmetic.DivideOperator;

public function divide(...operands):DivideOperator
{
    return new DivideOperator(operands);
}
}