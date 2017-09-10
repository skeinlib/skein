/**
 * Created by max on 4/5/16.
 */
package skein.rest.builder
{
import skein.core.PropertySetter;
import skein.rest.core.Config;

public class AuthBearerConfigBuilder
{
    public function AuthBearerConfigBuilder(builder:AuthConfigBuilder)
    {
        super();

        this.builder = builder;
    }

    private var builder:AuthConfigBuilder;

    public function token(value:Object):AuthBearerConfigBuilder
    {
        PropertySetter.set(Config.sharedInstance(), "token", value);

        return this;
    }

    public function build():AuthConfigBuilder
    {
        return builder;
    }
}
}
