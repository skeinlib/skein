/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/5/13
 * Time: 1:05 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.core
{
import flash.events.EventDispatcher;

import org.spicefactory.lib.reflect.ClassInfo;
import org.spicefactory.lib.reflect.Metadata;
import org.spicefactory.lib.reflect.Method;
import org.spicefactory.lib.reflect.Property;

public class Watcher
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    private static const CHANGE:String = "change";

    //--------------------------------------------------------------------------
    //
    //  Class functions
    //
    //--------------------------------------------------------------------------

    public static function watch(host:Object, chain:Object, callback:Function):Watcher
    {
        if (chain is String)
            chain = String(chain).split(".");

        if (chain.length == 0)
            return null;

        var watcher:Watcher = new Watcher(chain[0], callback, watch(null, chain.slice(1), callback));

        watcher.reset(host);

        return watcher;
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Watcher(access:Object, callback:Function, next:Watcher)
    {
        super();

        this.name = access is String ? access as String : access.name;
        this.getter = access is String ? null : access.getter;
        this.next = next;

        this.callback = callback;

        this.events = new <String>[];

        this.reset(host);
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var host:Object;


    private var getter:Function;


    private var name:String;




    private var events:Vector.<String>;

    private var callback:Function;

    private var next:Watcher;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Methods: Public API
    //-------------------------------------

    public function getValue(params:Array = null):Object
    {
        return next ? next.getValue(params) : this.getHostPropertyValue(params);
    }

    public function setHandler(callback:Function):void
    {
        this.callback = callback;

        if (this.next)
            this.next.setHandler(callback);
    }

    //-------------------------------------
    //  Methods: Public API
    //-------------------------------------

    //-------------------------------------
    //  Methods:
    //-------------------------------------

    public function unwatch():void
    {
        this.reset(null);
    }

    public function reset(host:Object):void
    {
        if (this.host)
        {
            while (this.events.length > 0)
            {
                this.host.removeEventListener(this.events.shift(), handler);
            }
        }

        this.host = host;

        if (this.host)
        {
            if (!this.host.hasOwnProperty("removeEventListener"))
            {
                throw new Error("Target should be an EventDispatcher instance.");
            }

            this.events = getEvents(host);

            for (var i:int = 0, n:int = this.events.length; i < n; i++)
            {
                if (this.host.addEventListener.length == 5)
                {
                    this.host.addEventListener(this.events[i], handler, false, 0, false);
                }
                else
                {
                    this.host.addEventListener(this.events[i], handler);
                }
            }
        }

        if (this.next)
            this.next.reset(this.getHostPropertyValue());
    }

    //------------------------------------
    //  Methods: Internal
    //------------------------------------

    private function getEvents(host:Object):Vector.<String>
    {
        var result:Vector.<String> = new <String>[];

        var info:ClassInfo = ClassInfo.forInstance(host);

        var property:Property = info.getProperty(this.name);

        result = getEventsFormProperty(info.getProperty(name)) ||
                 getEventsFormMethod(info.getMethod(name.substring(0, name.indexOf("()"))));

        if (result == null)
        {
            throw new ReferenceError("Property " + name + " not found on " + info.simpleName);
        }

//        //TODO: Throw warning if property not found.
//
//        var map:Object = {};
//
//        for each (var bind:Metadata in property.getMetadata("Bind", true))
//        {
//            result.push(bind.getArgument("event"));
//        }
//
//        for each (var bind:Metadata in property.getMetadata("Bindable", true))
//        {
//            result.push(bind.getDefaultArgument() || bind.getArgument("event"));
//        }

        return result;
    }

    private function getEventsFormProperty(property:Property):Vector.<String>
    {
        if (property == null)
            return null;

        var result:Vector.<String> = new <String>[];

        for each (var bind:Metadata in property.getMetadata("Bind", true))
        {
            result.push(bind.getArgument("event"));
        }

        for each (var bind:Metadata in property.getMetadata("Bindable", true))
        {
            result.push(bind.getDefaultArgument() || bind.getArgument("event"));
        }

        return result;
    }

    private function getEventsFormMethod(method:Method):Vector.<String>
    {
        if (method == null)
            return null;

        var result:Vector.<String> = new <String>[];

        for each (var bind:Metadata in method.getMetadata("Bind", true))
        {
            result.push(bind.getArgument("event"));
        }

        for each (var bind:Metadata in method.getMetadata("Bindable", true))
        {
            result.push(bind.getDefaultArgument() || bind.getArgument("event"));
        }

        return result;
    }

    private function getHostPropertyValue(params:Array = null):Object
    {
        if (!host)
            return null;

//        return getter != null ? getter(host) : host[name];

        if (getter != null)
            return getter(host);

        if (name.indexOf("()") != -1)
        {
            var f:Function = host[name.substring(0, name.indexOf("()"))];

            return f.apply(host, params);
        }

        return host[name];
    }

    //--------------------------------------------------------------------------
    //
    //  Handlers
    //
    //--------------------------------------------------------------------------

    public function handler(event:Object):void
    {
        if (next)
            next.reset(getHostPropertyValue());

        if (this.callback)
        {
            switch (this.callback.length)
            {
                case 0 : this.callback(); break;
                case 1 : this.callback(event); break;
            }
        }
    }
}
}