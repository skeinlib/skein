/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/22/14
 * Time: 7:01 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client.impl.extras
{
import skein.rest.client.extras.Downloader;
import skein.rest.client.impl.DefaultRestClient;
import skein.rest.client.impl.HandlerAbstract;

public class DownloaderHandler extends HandlerAbstract
{
    public function DownloaderHandler(client:DefaultRestClient)
    {
        super(client);
    }

    public function handle(downloader:Downloader):void
    {
        function resultHandler(data:Object=null):void
        {
            downloader.completeCallback(null);
            downloader.errorCallback(null);

            result(data);
        }

        function errorHandler(info:Object=null):void
        {
            downloader.completeCallback(null);
            downloader.errorCallback(null);

            error(info);
        }

        downloader.completeCallback(resultHandler);
        downloader.errorCallback(errorHandler);
    }
}
}
