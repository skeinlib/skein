/**
 * Created by max on 4/5/16.
 */
package skein.rest.builder
{
import skein.core.PropertySetter;
import skein.rest.core.Config;

public class AuthBasicConfigBuilder
{
    public function AuthBasicConfigBuilder(builder:AuthConfigBuilder)
    {
        super();

        this.builder = builder;
    }

    private var builder:AuthConfigBuilder;

    public function username(value:Object):AuthBasicConfigBuilder
    {
        PropertySetter.set(Config.sharedInstance(), "username", value);

        return this;
    }

    public function password(value:Object):AuthBasicConfigBuilder
    {
        PropertySetter.set(Config.sharedInstance(), "password", value);

        return this;
    }

    public function build():AuthConfigBuilder
    {
        return builder;
    }
}
}
