/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/7/14
 * Time: 5:59 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client.extras.download
{
import skein.rest.client.impl.extras.download.FileStreamAsyncDownloadWriter;
import skein.rest.client.impl.extras.download.URLStreamDownloadReader;

public class DownloadFactory
{
    public static function getWriter(to:Object):DownloadWriter
    {
        if (FileStreamAsyncDownloadWriter.isSupported())
        {
            return new FileStreamAsyncDownloadWriter();
        }

        return null;
    }

    public static function getReceiver(from:Object):DownloadReader
    {
        return new URLStreamDownloadReader();
    }
}
}
