/**
 * Created by max.rozdobudko@gmail.com on 9/18/17.
 */
package skein.rest.core.coding {
import flash.utils.ByteArray;

public class MultipartFormCoding {

    public static function encode(data:Object, callback:Function):void {
        var buffer: ByteArray = new ByteArray();
        var encoding: String = "utf-8";

        var boundary: String = generateBoundary();

        if ("toJSON" in data) {
            data = data.toJSON(undefined);
        }

        for (var property: String in data) {
            writeString(buffer, '--' + boundary + '\r\n' + 'Content-Disposition: form-data; name="' + property + '"\r\n\r\n', encoding);
            writeString(buffer, data[property] || '', encoding);
            writeString(buffer, '\r\n');
        }

        writeString(buffer, '--' + boundary + '--\r\n');

        if (callback.length == 2) {
            callback(buffer, 'multipart/form-data; boundary=' + boundary);
        } else {
            callback(buffer);
        }
    }

    private static function writeString(buffer: ByteArray, string: String, encoding: String = 'ascii'): void {
        var b:ByteArray = new ByteArray();
        b.writeMultiByte(string, encoding);
        buffer.writeBytes(b, 0, b.length);
    }

    /*
    Generate Multipart boundary based on the Apache HTTP Components
    http://hc.apache.org/httpcomponents-client-ga/httpmime/xref/org/apache/http/entity/mime/MultipartEntity.html
    */

    private static const MULTIPART_CHARS: String = "-_1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

    private static function generateBoundary(): String {
        var string: String = "";
        var count:int = int(Math.random() * 11) + 30; // a random size from 30 to 40
        for (var i: int = 0; i < count; i++) {
            string += MULTIPART_CHARS.charAt(int(Math.random() * MULTIPART_CHARS.length));
        }
        return string;
    }
}
}
