package skein.binding
{
import skein.binding.core.Binding;
import skein.binding.core.BindingContext;
import skein.binding.core.Destination;
import skein.binding.core.Source;
import skein.core.skein_internal;

use namespace skein_internal;

public function bind(destination:Destination, source:Source):Binding
{
    var binding = new BindingContext().bind(source, destination);

    return binding;
}
}