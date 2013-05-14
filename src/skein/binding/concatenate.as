package skein.binding
{
import skein.binding.operators.string.ConcatenateOperator;

public function concatenate(...operands):ConcatenateOperator
{
    return new ConcatenateOperator(operands);
}
}