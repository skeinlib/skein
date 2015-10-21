/**
 * Created by Max Rozdobudko on 10/6/15.
 */
package skein.rest.builder
{
import skein.core.skein_internal;
import skein.rest.core.Config;

use namespace skein_internal;

public class CacheConfigBuilder
{
    public function CacheConfigBuilder(parent:ConfigBuilder)
    {
        super();

        this.parent = parent;
    }

    private var parent:ConfigBuilder;

    private var ignoreParams:Array = [];

    public function ignoreParam(value:String):CacheConfigBuilder
    {
        ignoreParams.push(value);

        return this;
    }

    public function build():ConfigBuilder
    {
        Config.sharedInstance().setCacheIgnoreParams(ignoreParams);

        return parent;
    }
}
}
