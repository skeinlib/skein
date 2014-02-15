package skein.binding
{
import skein.binding.operators.logical.AndOperator;

public function and(...operands):AndOperator
{
    return new AndOperator(operands);
}
}