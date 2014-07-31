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
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function DownloaderHandler(client:DefaultRestClient)
    {
        super(client);
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var _downloader:Downloader;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function handle(downloader:Downloader):void
    {
        _downloader = downloader;

        _downloader.completeCallback(resultHandler);
        _downloader.errorCallback(errorHandler);
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden Methods
    //
    //--------------------------------------------------------------------------

    override protected function dispose():void
    {
        super.dispose();

        _downloader.completeCallback(null);
        _downloader.errorCallback(null);

        _downloader = null;
    }

    //--------------------------------------------------------------------------
    //
    //  Handlers
    //
    //--------------------------------------------------------------------------

    private function resultHandler(data:Object=null):void
    {
        result(data);
    }

    private function errorHandler(info:Object=null):void
    {
        error(info);
    }

}
}
