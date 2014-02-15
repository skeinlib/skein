/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 12/27/13
 * Time: 9:56 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes.builder
{
import skein.core.skein_internal;
import skein.tubes.Tube;
import skein.tubes.controls.Broadcast;
import skein.tubes.controls.Playback;
import skein.tubes.core.TubeRegistry;
import skein.tubes.data.MediaSettings;

use namespace skein_internal;

public class TubeBuilder
{
    public function TubeBuilder(name:String)
    {
        super();

        tube = TubeRegistry.get(name);
    }

    private var tube:Tube;

    public function settings(value:MediaSettings):TubeBuilder
    {
        tube.settings(value);

        return this;
    }

    public function broadcast(name:String):Broadcast
    {
        return tube.broadcast(name);
    }

    public function playback(name:String):Playback
    {
        return tube.playback(name);
    }
}
}
