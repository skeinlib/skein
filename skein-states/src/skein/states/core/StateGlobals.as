/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/24/13
 * Time: 1:21 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.states.core
{
import flash.utils.Dictionary;

import skein.core.skein_internal;
import skein.states.State;

use namespace skein_internal;

public class StateGlobals
{
    //---------------------------------------
    //  Common
    //---------------------------------------

    skein_internal static function dispose(host:Object):void
    {
        if (createdStates)
        {
            for (var name:String in createdStates[host])
            {
                var state:State = createdStates[host][name];

                handlers[state] = null;
                delete handlers[state];
            }

            createdStates[host] = null;
            delete createdStates[host];
        }

        if (currentStates)
        {
            currentStates[host] = null;
            delete currentStates[host];
        }
    }

    skein_internal static function getHostForState(state:State):Object
    {
        for (var host:Object in createdStates)
        {
            var states:Object = createdStates[host];

            for (var name:String in states)
            {
                if (states[name] == state)
                    return host;
            }
        }

        return null;
    }

    //---------------------------------------
    //  States
    //---------------------------------------

    private static var createdStates:Dictionary;
    private static var currentStates:Dictionary;

    skein_internal static function addState(host:Object, state:State):void
    {
        if (!createdStates)
            createdStates = new Dictionary(true);

        if (!createdStates[host])
            createdStates[host] = {};

        createdStates[host][state.name] = state;
    }

    skein_internal static function getState(host:Object, name:String):State
    {
         return createdStates && createdStates[host] ? createdStates[host][name] : null;
    }

    skein_internal static function getCurrentState(host:Object):State
    {
        if (!currentStates)
            return null;

        const name:String = currentStates[host];

        if (!name) return null;

        return getState(host, name);
    }

    skein_internal static function setCurrentState(host:Object, state:State):void
    {
        if (!currentStates)
            currentStates = new Dictionary(true);

        currentStates[host] = state ? state.name : null;
    }

    //---------------------------------------
    //  Handlers
    //---------------------------------------

    private static var handlers:Dictionary;

    skein_internal static function putHandler(state:State, property:String, event:String, handler:Function):void
    {
        var host:Object = getHostForState(state);

        if ("skeinSupport" in host)
        {
            var skein:Object = host.skeinSupport || (host.skeinSupport = {});

            if (!skein.handlers)
                skein.handlers = {};

            if (!skein.handlers[state.name])
                skein.handlers[state.name] = {};

            if (!skein.handlers[state.name][property])
                skein.handlers[state.name][property] = {};

            skein.handlers[state.name][property][event] = handler;
        }
        else
        {
            if (!handlers)
                handlers = new Dictionary(true);

            if (!handlers[state])
                handlers[state] = {};

            if (!handlers[state][property])
                handlers[state][property] = {};

            handlers[state][property][event] = handler;
        }
    }

    skein_internal static function getHandler(state:State, property:String, event:String):Function
    {
        const host:Object = getHostForState(state);

        if ("skeinSupport" in host)
        {
            var skein:Object = host.skeinSupport;

            if (!skein || !skein.handlers || !skein.handlers[state.name] || !skein.handlers[state.name][property])
                return null;

            return skein.handlers[state.name][property][event];
        }
        else
        {
            if (!handlers || !handlers[state] || !handlers[state][property])
                return null;

            return handlers[state][property][event];
        }
    }
}
}
