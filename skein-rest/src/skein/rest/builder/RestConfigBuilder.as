/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/17/13
 * Time: 7:58 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.builder
{
import skein.core.PropertySetter;
import skein.core.skein_internal;
import skein.rest.core.Config;
import skein.rest.core.HeaderHandler;

use namespace skein_internal;

public class RestConfigBuilder
{
    public function RestConfigBuilder(config:ConfigBuilder, url:String)
    {
        super();

        this.config = config;
        this.url = url;
    }

    private var config:ConfigBuilder;

    private var url:String;

    public function accessTokenKey(value:String):RestConfigBuilder
    {
        PropertySetter.set(Config.sharedInstance(), "accessTokenKey", value);

        return this;
    }

    public function accessToken(value:Object):RestConfigBuilder
    {
        PropertySetter.set(Config.sharedInstance(), "accessToken", value);

        return this;
    }

    public function header(name:String, handler:Function):RestConfigBuilder
    {
        HeaderHandler.register(name, handler);

        return this;
    }

    public function configure():ConfigBuilder
    {
        Config.rest(url);

        return config;
    }
}
}
