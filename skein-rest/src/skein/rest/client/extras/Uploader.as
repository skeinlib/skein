/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/23/14
 * Time: 3:10 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client.extras
{
import skein.rest.client.extras.upload.UploadFactory;
import skein.rest.client.extras.upload.UploadWriter;

public class Uploader
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Uploader()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var writer:UploadWriter;

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

    //------------------------------------
    //  statusCallback
    //------------------------------------

    protected var _statusCallback:Function;

    public function statusCallback(callback:Function):void
    {
        _statusCallback = callback;
    }

    //------------------------------------
    //  responseCallback
    //------------------------------------

    protected var _responseCallback:Function;

    public function responseCallback(callback:Function):void
    {
        _responseCallback = callback;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function upload(from:Object, to:Object, contentType:String, fields:Object = null):void
    {
        if (writer == null)
        {
            writer = UploadFactory.getUploadWriter();
            writer.completeCallback(writerCompleteCallback);
            writer.responseCallback(writerResponseCallback);
            writer.statusCallback(writerStatusCallback);
            writer.errorCallback(writerErrorCallback);
        }
        else
        {
            writer.close();
        }

        writer.load(from, to, contentType, fields);
    }

    public function close():void
    {
        if (writer != null)
        {
            writer.close();
            writer.completeCallback(null);
            writer.responseCallback(null);
            writer.statusCallback(null);
            writer.errorCallback(null);

            writer = null;
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Handlers
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Handlers: writer
    //-------------------------------------

    private function writerErrorCallback(info:Object):void
    {
        _errorCallback(info);
    }

    private function writerCompleteCallback(data:Object):void
    {
        _completeCallback(data);
    }

    private function writerStatusCallback(data:Object):void
    {
        _statusCallback(data);
    }

    private function writerResponseCallback(data:Object):void
    {
        _responseCallback(data);
    }
}
}
