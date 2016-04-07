/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 12:28 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder
{
import skein.components.builder.Builder;

import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;

public class FeathersBuilder implements Builder
{
    public function FeathersBuilder()
    {
        super();
    }

    protected var host:Object;

    protected var _instance:DisplayObject;

    protected var instanceId:Object;

//    protected function

    public function build():Object
    {
        if (this.instanceId)
        {
            if (host && Object(host).hasOwnProperty(this.instanceId.toString()))
                host[this.instanceId] = _instance;
        }

        return _instance;
    }

    public function addTo(host:Object = null):Object
    {
        var parent:DisplayObjectContainer =
            host as DisplayObjectContainer || this.host as DisplayObjectContainer;

        this.build();

        parent.addChild(_instance);

        return _instance;
    }

    protected function createInstance(generator:Class = null):void
    {

    }
}
}
