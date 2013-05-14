package skein.binding
{
import skein.binding.operators.logical.OrOperator;

public function or(...operands):OrOperator
{
    return OrOperator(operands);
}
}
