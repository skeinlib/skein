/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 1/3/14
 * Time: 11:56 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes.tube.sharing
{
import skein.tubes.tube.sharing.replication.*;

import avmplus.getQualifiedClassName;

import flash.events.EventDispatcher;
import flash.events.NetStatusEvent;
import flash.net.NetGroup;
import flash.utils.getDefinitionByName;

import skein.core.skein_internal;

import skein.tubes.core.Config;
import skein.tubes.tube.sharing.replication.ShareWriter;

use namespace skein_internal;

public class Taker extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    private static const PACKAGE_SIZE:uint = 1024;

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Taker(data:Object, start:Number, end:Number, autoStart:Boolean=true)
    {
        super();

        var type:Class = getDefinitionByName(getQualifiedClassName(data)) as Class;

        writer = Config.shared.getWriter(type);
        writer.setTarget(data);

        this.startIndex = this.currentIndex = start;
        this.endIndex = end;

        if (autoStart)
            this.start();
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    protected var data:Object;

    protected var writer:ShareWriter;

    protected var currentIndex:Number;

    protected var startIndex:Number;

    protected var endIndex:Number;

    private var isStarted:Boolean;

    private var isPaused:Boolean;

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  group
    //-------------------------------------

    private var group:NetGroup;

    skein_internal function setGroup(value:NetGroup):void
    {
        if (group)
        {
            group.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);

            if (isStarted && !isPaused)
                group.removeHaveObjects(currentIndex, endIndex);
        }

        group = value;

        if (group)
        {
            group.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);

            if (isStarted && !isPaused)
                group.removeHaveObjects(currentIndex, endIndex);
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function start():void
    {
        if (!isStarted)
        {
            isStarted = true;

            if (group)
            {
                group.addWantObjects(currentIndex, endIndex);
            }
        }
    }

    public function pause():void
    {
        if (!isPaused)
        {
            isPaused = true;

            if (group)
                group.removeWantObjects(currentIndex, endIndex);
        }
    }

    public function resume():void
    {
        if (isPaused)
        {
            isPaused = false;

            if (group)
                group.addHaveObjects(currentIndex, endIndex);
        }
    }

    public function cancel():void
    {

    }

    //---------------------------------------
    //  Methods internal
    //---------------------------------------

    protected function handleResult(index:Number, object:Object):void
    {
        currentIndex = index;

        group.removeWantObjects(currentIndex, currentIndex);

        writer.write(index, PACKAGE_SIZE, object,
            function(data:Object):void
            {
//                group.addHaveObjects(index, index);
            });
    }

    //--------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //--------------------------------------------------------------------------

    private function netStatusHandler(event:NetStatusEvent):void
    {
        switch (event.info.code)
        {
            case "NetGroup.Replication.Fetch.Result" :

                handleResult(event.info.index, event.info.object);

                break;
        }
    }
}
}
