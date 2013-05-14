package skein.binding
{
import skein.binding.operators.string.SubstituteOperator;

public function substitute(pattern:String, ...operands):SubstituteOperator
{
    return new SubstituteOperator(pattern, operands);
}
}