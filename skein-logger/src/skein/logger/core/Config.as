/**
 * Created by max.rozdobudko@gmail.com on 12/7/17.
 */
package skein.logger.core {
import flash.utils.Dictionary;

import skein.core.skein_internal;
import skein.logger.Log;
import skein.logger.Logger;
import skein.logger.LoggerAppender;
import skein.logger.impl.DefaultLogger;

use namespace skein_internal;

public class Config {

    //  Shared instance

    private static var instance:Config;
    public static function get sharedInstance(): Config {
        if (instance == null)
            instance = new Config();
        return instance;
    }

    // Contracts

    private static var _defaultImplementations: Dictionary = new Dictionary();
    {
        _defaultImplementations[Logger] = DefaultLogger;
    }

    private static var _implementations: Object = {};
    skein_internal static function setImplementationForTag(tag: String, contract:Class, implementation:Class):void {
        if (!_implementations.hasOwnProperty(tag)) {
            _implementations = new Dictionary();
        }
        _implementations[tag][contract] = implementation;
    }
    skein_internal static function getImplementationForTag(tag: String, contract: Class): Class {
        if (_implementations.hasOwnProperty(tag)) {
            return _implementations[tag][contract] || _defaultImplementations[contract];
        }
        return _defaultImplementations[contract];
    }

    // Log Level

    private static var _tagLogLevels: Object = {};
    skein_internal static function logLevelForTag(tag: String): Object {
        if (!_tagLogLevels.hasOwnProperty(tag)) {
            _tagLogLevels[tag] = {
                logLevel : Log.DEFAULT
            };
        }
        return _tagLogLevels[tag];
    }
    skein_internal static function setLogLevelForTag(tag: String, logLevel: uint) {
        logLevelForTag(tag).logLevel = logLevel;
    }
    skein_internal static function getLogLevelForTag(tag: String): uint {
        return logLevelForTag(tag).logLevel;
    }

    //  Appenders

    private static var _loggerAppenders: Object = {};
    skein_internal static function releaseLoggerAppenders(tag: String):Vector.<LoggerAppender> {
        var result:Vector.<LoggerAppender> = _loggerAppenders[tag];
        _loggerAppenders[tag] = null;
        return result;
    }
    skein_internal static function retainLoggerAppendersForTag(tag: String, value:Vector.<LoggerAppender>):void {
        _loggerAppenders[tag] = value;
    }

}
}
