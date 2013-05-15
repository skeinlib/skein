package skein.binding
{
import skein.binding.operators.comparison.EqualOperator;

public function equal(...operands):EqualOperator
{
    return new EqualOperator(operands)
}
}