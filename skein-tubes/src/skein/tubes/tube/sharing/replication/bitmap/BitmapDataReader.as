/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 1/3/14
 * Time: 12:36 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes.tube.sharing.replication.bitmap
{
import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.utils.ByteArray;

import skein.tubes.tube.sharing.replication.ShareReader;

public class BitmapDataReader implements ShareReader
{
    public function BitmapDataReader()
    {
        super();
    }

    private var bmd:BitmapData;

    private var bytes:ByteArray;

    private var size:uint;

    public function setSource(source:Object, size:uint):void
    {
        bmd = source as BitmapData;

        this.size = size;

        bmd.copyPixelsToByteArray(new Rectangle(0, 0, bmd.width, bmd.height), bytes);
    }

    public function read(index:Number, chunkSize:uint, callback:Function):void
    {
        if (index == 0)
        {
            var header:HeaderBitmapData = new HeaderBitmapData();
            header.width = bmd.width;
            header.height = bmd.height;

            callback(header);
        }
        else
        {
            var chunk:ByteArray = new ByteArray();

            index = index - 1;

            bytes.readBytes(chunk, index * chunkSize, chunkSize);

            callback(chunk);
        }
    }
}
}
