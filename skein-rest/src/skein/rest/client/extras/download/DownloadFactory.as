/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/7/14
 * Time: 5:59 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client.extras.download
{
import skein.rest.client.impl.extras.download.FileStreamDownloadWriter;
import skein.rest.client.impl.extras.download.URLStreamDownloadReceiver;

public class DownloadFactory
{
    public static function getWriter(to:Object):DownloadWriter
    {
        if (FileStreamDownloadWriter.isSupported())
        {
            return new FileStreamDownloadWriter();
        }

        return null;
    }

    public static function getReceiver(from:Object):DownloadReceiver
    {
        return new URLStreamDownloadReceiver();
    }
}
}
