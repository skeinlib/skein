package skein.tubes
{
import skein.Tubes;
import skein.tubes.builder.TubeBuilder;

public function tubes(name:String):TubeBuilder
{
    return Tubes.tube(name);
}
}