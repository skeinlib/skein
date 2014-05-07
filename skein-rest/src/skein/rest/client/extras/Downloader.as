/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/7/14
 * Time: 12:13 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client.extras
{
import flash.events.EventDispatcher;

import skein.rest.client.extras.download.DownloadFactory;
import skein.rest.client.extras.download.DownloadReceiver;
import skein.rest.client.extras.download.DownloadWriter;

public class Downloader extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Downloader()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var writer:DownloadWriter;

    private var receiver:DownloadReceiver;

    private var callback:Function;

    private var isWriterComplete:Boolean = false;
    private var isReceiverComplete:Boolean = false;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function download(from:Object, to:Object, callback:Function):void
    {
        writer = DownloadFactory.getWriter(to);
        writer.errorCallback(writerErrorCallback);
        writer.completeCallback(writerCompleteCallback);
        writer.start(to);

        receiver = DownloadFactory.getReceiver(from);
        receiver.progressCallback(receiverProgressCallback);
        receiver.completeCallback(receiverCompleteCallback);
        receiver.errorCallback(receiverErrorCallback);
        receiver.start(from);

        this.callback = callback;
    }

    protected function complete():void
    {
        if (isWriterComplete && isReceiverComplete)
        {
            close();

            callback();
        }
    }

    protected function error(error:Error):void
    {
        close();

        callback(error);
    }

    public function close():void
    {
        if (writer != null)
        {
            writer.close();
            writer = null;
        }

        if (receiver != null)
        {
            receiver.close();
            receiver = null;
        }

        isWriterComplete = isReceiverComplete = false;
    }

    //--------------------------------------------------------------------------
    //
    //  Callbacks
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Callbacks: writer
    //-------------------------------------

    private function writerErrorCallback(error:Error):void
    {
        this.error(error);
    }

    private function writerCompleteCallback():void
    {
        isWriterComplete = true;

        this.complete();
    }

    //-------------------------------------
    //  Callbacks: receiver
    //-------------------------------------

    private function receiverProgressCallback():void
    {
        writer.write(receiver.getBytes());
    }

    private function receiverCompleteCallback():void
    {
        writer.write(receiver.getBytes(), true);

        isReceiverComplete = true;

        this.complete();
    }

    private function receiverErrorCallback(error:Error):void
    {
        this.error(error);
    }
}
}
