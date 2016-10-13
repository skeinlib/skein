package skein.binding
{
import skein.binding.operators.misc.IndexOfOperator;

public function indexOf(source:Object, search:Object):IndexOfOperator
{
    return new IndexOfOperator(source, search);
}
}