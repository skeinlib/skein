package skein.binding
{
import skein.binding.operators.arithmetic.AddOperator;

public function add(...operands):AddOperator
{
    return new AddOperator(operands);
}
}