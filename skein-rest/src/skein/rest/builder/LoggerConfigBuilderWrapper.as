/**
 * Created by max.rozdobudko@gmail.com on 12/7/17.
 */
package skein.rest.builder {
import skein.logger.LoggerAppender;
import skein.logger.builder.LoggerConfigBuilder;

public class LoggerConfigBuilderWrapper {

    public function LoggerConfigBuilderWrapper(config: ConfigBuilder, builder: LoggerConfigBuilder) {
        super();
        _config = config;
        _builder = builder;
    }

    private var _config: ConfigBuilder;
    private var _builder: LoggerConfigBuilder;


    public function setImplementation(value:Class):LoggerConfigBuilderWrapper {
        _builder.setImplementation(value);
        return this;
    }

    //------------------------------------
    //  level
    //------------------------------------

    public function level(value:Object):LoggerConfigBuilderWrapper {
        _builder.level(value);
        return this;
    }

    //------------------------------------
    //  appender
    //------------------------------------

    public function appender(value:LoggerAppender):LoggerConfigBuilderWrapper {
        _builder.appender(value);
        return this;
    }

    //------------------------------------
    //  appenders
    //------------------------------------

    public function appenders(value:Vector.<LoggerAppender>):LoggerConfigBuilderWrapper {
        _builder.appenders(value);
        return this;
    }

    //------------------------------------
    //  build
    //------------------------------------

    public function build(): ConfigBuilder {
        _builder.build();
        return _config;
    }
}
}
