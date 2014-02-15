package skein.binding
{
import skein.binding.operators.conditional.ConditionalOperator;

public function condition(operand:Object):ConditionalOperator
{
    return new ConditionalOperator(operand);
}
}