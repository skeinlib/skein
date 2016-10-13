package skein.binding
{
import skein.binding.operators.string.LowerCaseOperator;

public function lowerCase(...operands):LowerCaseOperator
{
    return new LowerCaseOperator(operands);
}
}