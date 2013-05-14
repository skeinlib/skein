package skein.binding
{
import skein.binding.operators.arithmetic.MultiplyOperator;

public function multiply(...operands):MultiplyOperator
{
    return new MultiplyOperator(operands);
}
}