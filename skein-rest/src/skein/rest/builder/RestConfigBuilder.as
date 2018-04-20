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
    public function RestConfigBuilder(config: ConfigBuilder, url: String = null) {
        super();

        this.config = config;

        PropertySetter.set(Config.sharedInstance(), "rest", url);
    }

    private var config: ConfigBuilder;

    public function url(value: Object): RestConfigBuilder {
        PropertySetter.set(Config.sharedInstance(), "rest", value);
        return this;
    }

    public function accessTokenKey(value:String): RestConfigBuilder {
        PropertySetter.set(Config.sharedInstance(), "accessTokenKey", value);
        return this;
    }

    public function accessToken(value: Object): RestConfigBuilder {
        PropertySetter.set(Config.sharedInstance(), "accessToken", value);
        return this;
    }

    public function beforeResultHook(hook: Function): RestConfigBuilder {
        Config.setBeforeResultHook(hook);
        return this;
    }

    public function afterResultHook(hook: Function): RestConfigBuilder {
        Config.setAfterResultHook(hook);
        return this;
    }

    public function errorHook(hook: Function): RestConfigBuilder {
        Config.setErrorHook(hook);
        return this;
    }

    public function errorDecoder(decoder: Function): RestConfigBuilder {
        Config.setErrorDecoder(decoder);
        return this;
    }

    public function progressHandler(handler: Function): RestConfigBuilder {
        Config.setProgressHandler(handler);
        return this;
    }

    public function header(name:String, handler: Function): RestConfigBuilder {
        HeaderHandler.register(name, handler);
        return this;
    }

    public function fixKnownIssues(value: Boolean=true): RestConfigBuilder {
        Config.sharedInstance().setFixKnownIssues(true);
        return this;
    }

    public function useCache(value: Object): RestConfigBuilder {
        PropertySetter.set(Config.sharedInstance(), "useCache", value);
        return this;
    }

    public function useQueue(value: Object): RestConfigBuilder {
        PropertySetter.set(Config.sharedInstance(), "useQueue", value);
        return this;
    }
    
    public function build():ConfigBuilder {
        return config;
    }
}
}
