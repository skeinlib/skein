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
    public function UploaderHandler(client:DefaultRestClient)
    {
        super(client);
    }

    public function handle(uploader:Uploader):void
    {
        function statusHandler(info:Object):void
        {
            if (info is HTTPStatusEvent)
            {
                status(HTTPStatusEvent(info).status);
            }
        }

        function responseHandler(info:Object):void
        {
            if (info is HTTPStatusEvent)
            {
                headers(HTTPStatusEvent(info).responseHeaders);
            }
        }

        function completeHandler(data:Object=null):void
        {
            uploader.completeCallback(null);
            uploader.statusCallback(null);
            uploader.responseCallback(null);
            uploader.errorCallback(null);

            if (responseCode >= 200 && responseCode < 300) // result
            {
                result(data);
            }
            else // error
            {
                error(data)
            }
        }

        function errorHandler(info:Object=null):void
        {
            uploader.completeCallback(null);
            uploader.statusCallback(null);
            uploader.responseCallback(null);
            uploader.errorCallback(null);

            error(info);
        }

        uploader.completeCallback(completeHandler);
        uploader.responseCallback(responseHandler);
        uploader.statusCallback(statusHandler);
        uploader.errorCallback(errorHandler);
    }
}
}
