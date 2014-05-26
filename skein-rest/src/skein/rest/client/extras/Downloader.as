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
import skein.rest.client.extras.download.DownloadReader;
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

    private var receiver:DownloadReader;

    private var isWriterComplete:Boolean = false;
    private var isReceiverComplete:Boolean = false;

    //--------------------------------------------------------------------------
    //
    //  Callbacks
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  errorCallback
    //------------------------------------

    protected var _errorCallback:Function;

    public function errorCallback(callback:Function):void
    {
        _errorCallback = callback;
    }

    //------------------------------------
    //  completeCallback
    //------------------------------------

    protected var _completeCallback:Function;

    public function completeCallback(callback:Function):void
    {
        _completeCallback = callback;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function download(from:Object, to:Object):void
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
    }

    protected function complete():void
    {
        if (isWriterComplete && isReceiverComplete)
        {
            close();

            _completeCallback();
        }
    }

    protected function error(error:Error):void
    {
        close();

        _errorCallback(error);
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
    //  Handlers
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Handlers: writer
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
    //  Handlers: receiver
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
