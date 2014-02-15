package skein.binding
{
import skein.binding.operators.conditional.SwitchOperator;

public function inspect(control:Object):SwitchOperator
{
    return new SwitchOperator(control);
}
}