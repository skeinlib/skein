/**
 * Created by Max Rozdobudko on 10/20/15.
 */
package skein.rest.builder
{
import skein.core.PropertySetter;
import skein.core.skein_internal;
import skein.rest.core.Config;
import skein.rest.logger.Logger;
import skein.rest.logger.LoggerAppender;
import skein.rest.logger.impl.SimpleLoggerLayout;
import skein.rest.logger.impl.TraceLoggerAppender;

use namespace skein_internal;

public class LoggerConfigBuilder
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function LoggerConfigBuilder(parent:ConfigBuilder)
    {
        super();

        this.parent = parent;
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var parent:ConfigBuilder;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  setImplementation
    //------------------------------------

    public function setImplementation(value:Class):LoggerConfigBuilder
    {
        Config.setImplementation(Logger, value);

        return this;
    }

    //------------------------------------
    //  level
    //------------------------------------

    public function level(value:Object):LoggerConfigBuilder
    {
        PropertySetter.set(Config.sharedInstance(), "logLevel", value);

        return this;
    }

    //------------------------------------
    //  appender
    //------------------------------------

    public function appender(value:LoggerAppender):LoggerConfigBuilder
    {
        if (_appenders == null)
        {
            _appenders = new <LoggerAppender>[value];
        }
        else
        {
            _appenders.push(value);
        }

        return this;
    }

    //------------------------------------
    //  appenders
    //------------------------------------

    private var _appenders:Vector.<LoggerAppender> = new <LoggerAppender>[new TraceLoggerAppender(new SimpleLoggerLayout())];

    public function appenders(value:Vector.<LoggerAppender>):LoggerConfigBuilder
    {
        _appenders = value;

        return this;
    }

    //------------------------------------
    //  build
    //------------------------------------

    public function build():ConfigBuilder
    {
        Config.sharedInstance().retainLoggerAppenders(_appenders);

        return parent;
    }
}
}
