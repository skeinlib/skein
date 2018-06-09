package skein.tubes {
import skein.tubes.core.TubeRegistry;
import skein.tubes.tube.Tube;

public function tube(name: String): Tube {
    return TubeRegistry.get(name);
}
}