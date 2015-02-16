/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/17/13
 * Time: 7:57 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.builder
{
import skein.core.skein_internal;
import skein.rest.client.RestClient;
import skein.rest.core.Config;

use namespace skein_internal;

public class ConfigBuilder
{
    function ConfigBuilder()
    {
        super();
    }

    public function auth(url:String):AuthConfigBuilder
    {
        return new AuthConfigBuilder(this, url);
    }

    public function rest(url:String = null):RestConfigBuilder
    {
        return new RestConfigBuilder(this, url);
    }

    public function client(implementation:Class):ConfigBuilder
    {
        Config.setImplementation(RestClient, implementation);

        return this;
    }

    public function setImplementation(contract:Class, implementation:Class):ConfigBuilder
    {
        Config.setImplementation(contract, implementation);

        return this;
    }
}
}
