package skein.binding.misc
{
import skein.binding.operators.misc.LabelFunctionOperator;

public function labelize(data:Object, labelFunction:Function):LabelFunctionOperator
{
    return new LabelFunctionOperator(data, labelFunction);
}
}