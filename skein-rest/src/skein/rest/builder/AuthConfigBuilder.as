/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/17/13
 * Time: 7:58 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.builder
{
import skein.core.skein_internal;
import skein.rest.core.Config;

use namespace skein_internal;

public class AuthConfigBuilder
{
    public function AuthConfigBuilder(config:ConfigBuilder, url:String)
    {
        super();

        this.config = config;
        this.url = url;
    }

    private var config:ConfigBuilder;

    private var url:String;

    public function basic():AuthBasicConfigBuilder
    {
        return new AuthBasicConfigBuilder(this);
    }

    public function bearer(): AuthBearerConfigBuilder {
        return new AuthBearerConfigBuilder(this);
    }

    public function build():ConfigBuilder
    {
        Config.skein_internal::auth(url);

        return config;
    }
}
}
