/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/26/13
 * Time: 2:46 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.locale.core.source
{
import flash.events.EventDispatcher;

import skein.locale.core.Source;

public class EmbeddedSource extends EventDispatcher implements Source
{
    public function EmbeddedSource(content:Object)
    {
        super();

        this.content = content;
    }

    private var content:Object;

    public function isLoaded():Boolean
    {
        return true;
    }

    public function getData():Object
    {
        return content;
    }

    public function load():void
    {
    }
}
}
