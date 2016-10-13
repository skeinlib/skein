package skein.binding
{
import skein.binding.operators.string.UpperCaseOperator;

public function upperCase(...operands):UpperCaseOperator
{
    return new UpperCaseOperator(operands);
}
}