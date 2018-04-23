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
import skein.logger.builder.LoggerConfigBuilder;
import skein.rest.client.RestClient;
import skein.rest.core.Config;

use namespace skein_internal;

public class ConfigBuilder
{
    function ConfigBuilder(key: String) {
        super();
        _key = key;
    }

    private var _key: String;
    public function get key(): String {
        return _key;
    }

    public function auth(url: String = null): AuthConfigBuilder {
        return new AuthConfigBuilder(this, url);
    }

    public function rest(url: Object = null): RestConfigBuilder {
        return new RestConfigBuilder(this, url);
    }

    public function cache(): CacheConfigBuilder {
        return new CacheConfigBuilder(this);
    }

    public function logger(): LoggerConfigBuilderWrapper {
        return new LoggerConfigBuilderWrapper(this, new LoggerConfigBuilder("skein-rest"));
    }

    public function client(implementation: Class): ConfigBuilder {
        Config.setImplementation(RestClient, implementation);
        return this;
    }

    public function setImplementation(contract: Class, implementation: Class): ConfigBuilder {
        Config.setImplementation(contract, implementation);
        return this;
    }
}
}
