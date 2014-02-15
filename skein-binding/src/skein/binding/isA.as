package skein.binding
{
import skein.binding.operators.other.IsOperator;

public function isA(instance:Object, type:Object):IsOperator
{
    return new IsOperator(instance, type);
}
}