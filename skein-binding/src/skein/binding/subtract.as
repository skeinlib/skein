package skein.binding
{
import skein.binding.operators.arithmetic.SubtractOperator;

public function subtract(...operands):SubtractOperator
{
    return new SubtractOperator(operands);
}
}