/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 1/3/14
 * Time: 12:46 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes.tube.sharing.replication.bitmap
{
import skein.tubes.tube.sharing.replication.*;

import flash.display.BitmapData;
import flash.utils.ByteArray;

import skein.tubes.tube.sharing.replication.ShareWriter;

public class BitmapDataWriter implements ShareWriter
{
    public function BitmapDataWriter()
    {
        super();
    }

    private var bmd:BitmapData;

    private var bytes:ByteArray;

    public function setTarget(target:Object):void
    {
        bmd = target as BitmapData;
    }

    public function write(index:Number, chunkSize:uint, chunk:Object, callback:Function):void
    {
        if (chunk is HeaderBitmapData)
        {

        }
        else
        {
            bytes.writeBytes(chunk as ByteArray, index * chunkSize, chunkSize);

            callback();
        }
    }
}
}
