/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 12/28/13
 * Time: 4:28 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes.controls
{
import avmplus.getQualifiedClassName;

import flash.events.EventDispatcher;
import flash.events.NetStatusEvent;
import flash.net.NetGroup;
import flash.utils.getDefinitionByName;

import skein.core.skein_internal;
import skein.tubes.core.Config;
import skein.tubes.core.ShareReader;

public class Giver extends EventDispatcher      // Quota
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

    public function Giver(data:Object, start:Number, end:Number, autoStart:Boolean=true)
    {
        super();

        var type:Class = getDefinitionByName(getQualifiedClassName(data)) as Class;

        reader = Config.sharedInstance().getReader(type);
        reader.setSource(data, PACKAGE_SIZE);

        this.startIndex = start;
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

    protected var reader:ShareReader;

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
                group.removeHaveObjects(startIndex, endIndex);
        }

        group = value;

        if (group)
        {
            group.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);

            if (isStarted && !isPaused)
                group.removeHaveObjects(startIndex, endIndex);
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
                group.addHaveObjects(startIndex, endIndex);
            }
        }
    }

    public function pause():void
    {
        if (!isPaused)
        {
            isPaused = true;

            if (group)
                group.removeHaveObjects(startIndex, endIndex);
        }
    }

    public function resume():void
    {
        if (isPaused)
        {
            isPaused = false;

            if (group)
                group.addHaveObjects(startIndex, endIndex);
        }
    }

    public function cancel():void
    {

    }

    //---------------------------------------
    //  Methods internal
    //---------------------------------------

    protected function handleRequest(requestId:int, index:Number):void
    {
        reader.read(index, PACKAGE_SIZE,
            function(data:Object):void
            {
                group.writeRequestedObject(requestId, data);
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
            case "NetGroup.Replication.Request" :

                handleRequest(event.info.requestID, event.info.index);

                break;
        }
    }
}
}
