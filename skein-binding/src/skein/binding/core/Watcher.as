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

import skein.core.NullReference;

import skein.core.Reference;
import skein.core.WeakReference;

public class Watcher
{
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

        this.setName(access);

        this.setGetter(access);

        this.callback = callback;

        this.next = next;
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var host:Reference = new NullReference();

    private var getter:Function;

    private var propertyName:String;

    private var methodName:String;

    private var events:Vector.<String> = new <String>[];

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

    public function unwatch():void
    {
        this.reset(null);
    }

    //-------------------------------------
    //  Methods: Watcher
    //-------------------------------------

    internal function reset(newHost:Object):void
    {
        var host:Object = this.getHost();

        if (host)
        {
            while (this.events.length > 0)
            {
                host.removeEventListener(this.events.shift(), handler);
            }
        }

        host = this.setHost(newHost);

        if (host)
        {
            if (!host.hasOwnProperty("removeEventListener"))
            {
                throw new Error("Target should be an EventDispatcher instance.");
            }

            this.events = getEvents(host);

            for (var i:int = 0, n:int = this.events.length; i < n; i++)
            {
                if (host.addEventListener.length == 5)
                {
                    host.addEventListener(this.events[i], handler, false, 0, false);
                }
                else
                {
                    host.addEventListener(this.events[i], handler);
                }
            }
        }

        if (this.next)
            this.next.reset(this.getHostPropertyValue());
    }

    private function getHost():Object
    {
        return this.host.value;
    }

    private function setHost(value:Object):Object
    {
        this.host = value ? new WeakReference(value) : new NullReference();

        return value;
    }

    private function getHostPropertyValue(params:Array = null):Object
    {
        var host:Object = this.getHost();

        if (host == null)
            return null;

        if (getter != null)
            return getter(host);

        if (this.methodName != null)
        {
            var f:Function = host[this.methodName] as Function;

            return f.apply(host, params);
        }

        return host[this.propertyName];
    }

    //------------------------------------
    //  Methods: Internal
    //------------------------------------

    private function setName(access:Object):void
    {
        var name:String = access is String ? access as String : access.name;

        if (name.indexOf("()") != -1)
        {
            this.methodName = name.substring(0, name.indexOf("()"));
        }
        else
        {
            this.propertyName = name;
        }
    }

    private function setGetter(access:Object):void
    {
        this.getter = access is String ? null : access.getter;
    }

    private function getEvents(host:Object):Vector.<String>
    {
        var result:Vector.<String>;

        var info:ClassInfo = ClassInfo.forInstance(host);

        if (this.propertyName != null)
        {
            var property:Property = info.getProperty(this.propertyName);

            if (property == null)
            {
                throw new ReferenceError("Property " + this.propertyName + " not found on class " + info.simpleName);
            }

            result = getEventsFormProperty(property);

            if (result.length == 0)
            {
                trace("[Binding] Warning: Unable to find binding events for property '" + this.propertyName + "' on class '" + info.simpleName + "'");
            }
        }

        if (this.methodName != null)
        {
            var method:Method = info.getMethod(this.methodName);

            if (method == null)
            {
                throw new ReferenceError("Method " + this.methodName + " not found on class " + info.simpleName);
            }

            result = getEventsFormMethod(method);

            if (result.length == 0)
            {
                trace("[Binding] Warning: Unable to find binding events for method '" + this.methodName + "' on class '" + info.simpleName + "'");
            }
        }

        return result;
    }

    private function getEventsFormProperty(property:Property):Vector.<String>
    {
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
