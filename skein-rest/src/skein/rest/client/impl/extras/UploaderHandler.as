/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/22/14
 * Time: 6:57 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client.impl.extras
{
import flash.events.HTTPStatusEvent;

import skein.rest.client.extras.Uploader;
import skein.rest.client.impl.DefaultRestClient;
import skein.rest.client.impl.HandlerAbstract;

public class UploaderHandler extends HandlerAbstract
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function UploaderHandler(client:DefaultRestClient)
    {
        super(client);
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var _uploader:Uploader;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function handle(uploader:Uploader):void
    {
        _uploader = uploader;

        _uploader.completeCallback(completeHandler);
        _uploader.responseCallback(responseHandler);
        _uploader.statusCallback(statusHandler);
        _uploader.errorCallback(errorHandler);
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden Methods
    //
    //--------------------------------------------------------------------------

    override protected function dispose():void
    {
        super.dispose();

        _uploader.completeCallback(null);
        _uploader.statusCallback(null);
        _uploader.responseCallback(null);
        _uploader.errorCallback(null);

        _uploader = null;
    }

    //--------------------------------------------------------------------------
    //
    //  Handlers
    //
    //--------------------------------------------------------------------------

    private function statusHandler(info:Object):void
    {
        if (info is HTTPStatusEvent)
        {
            status(HTTPStatusEvent(info).status);
        }
    }

    private function responseHandler(info:Object):void
    {
        if (info is HTTPStatusEvent)
        {
            headers(HTTPStatusEvent(info).responseHeaders);
        }
    }

    private function completeHandler(data:Object=null):void
    {
        if (responseCode >= 200 && responseCode < 300) // result
        {
            result(data);
        }
        else // error
        {
            error(data)
        }
    }

    private function errorHandler(info:Object=null):void
    {
        error(info);
    }
}
}
