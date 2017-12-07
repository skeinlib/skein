/**
 * Created by Max Rozdobudko on 10/20/15.
 */
package skein.logger.builder
{
import skein.core.PropertySetter;
import skein.core.skein_internal;
import skein.logger.Logger;
import skein.logger.LoggerAppender;
import skein.logger.core.Config;
import skein.logger.impl.SimpleLoggerLayout;
import skein.logger.impl.TraceLoggerAppender;

use namespace skein_internal;

public class LoggerConfigBuilder
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function LoggerConfigBuilder(tag: String) {
        super();

        _tag = tag;
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var _tag: String;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  setImplementation
    //------------------------------------

    public function setImplementation(value:Class):LoggerConfigBuilder {
        Config.setImplementationForTag(_tag, Logger, value);
        return this;
    }

    //------------------------------------
    //  level
    //------------------------------------

    public function level(value:Object):LoggerConfigBuilder {
        PropertySetter.set(Config.logLevelForTag(_tag), "logLevel", value);
        return this;
    }

    //------------------------------------
    //  appender
    //------------------------------------

    public function appender(value:LoggerAppender):LoggerConfigBuilder {
        if (_appenders == null) {
            _appenders = new <LoggerAppender>[value];
        } else {
            _appenders.push(value);
        }
        return this;
    }

    //------------------------------------
    //  appenders
    //------------------------------------

    private var _appenders:Vector.<LoggerAppender> = new <LoggerAppender>[new TraceLoggerAppender(new SimpleLoggerLayout())];
    public function appenders(value:Vector.<LoggerAppender>):LoggerConfigBuilder {
        _appenders = value;
        return this;
    }

    //------------------------------------
    //  build
    //------------------------------------

    public function build(): void {
        Config.retainLoggerAppendersForTag(_tag, _appenders);
    }
}
}
