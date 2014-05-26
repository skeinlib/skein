/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/22/14
 * Time: 6:57 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client.impl.extras
{
import skein.rest.client.extras.Uploader2;
import skein.rest.client.extras.Uploader3;
import skein.rest.client.impl.DefaultRestClient;
import skein.rest.client.impl.HandlerAbstract;

public class UploaderHandler extends HandlerAbstract
{
    public function UploaderHandler(client:DefaultRestClient)
    {
        super(client);
    }

    public function handle(uploader:Uploader3):void
    {
        function resultHandler(data:Object=null):void
        {
            uploader.completeCallback(null);
            uploader.errorCallback(null);

            result(data);
        }

        function errorHandler(info:Object=null):void
        {
            uploader.completeCallback(null);
            uploader.errorCallback(null);

            error(info);
        }

        uploader.completeCallback(resultHandler);
        uploader.errorCallback(errorHandler);
    }
}
}
