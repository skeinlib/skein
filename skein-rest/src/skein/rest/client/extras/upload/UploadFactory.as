/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/23/14
 * Time: 1:49 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.client.extras.upload
{
import skein.rest.core.Config;

public class UploadFactory
{
    public static function getUploadWriter():UploadWriter
    {
        var Type:Class = Config.sharedInstance().getImplementation(UploadWriter);

        return Type != null ? new Type() : null;
    }
}
}
