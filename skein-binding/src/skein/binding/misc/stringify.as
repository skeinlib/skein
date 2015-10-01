package skein.binding.misc
{
import skein.binding.operators.misc.StringifyOperator;

public function stringify(object:Object):StringifyOperator
{
    return new StringifyOperator(object);
}
}