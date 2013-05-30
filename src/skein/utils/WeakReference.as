/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/26/13
 * Time: 10:07 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.utils
{
import flash.utils.Dictionary;

public class WeakReference implements Reference
{
    public function WeakReference(value:Object)
    {
        super();

        d = new Dictionary(true);

        d[value] = true;
    }

    private var d:Dictionary;

    public function get value():*
    {
        for (var value:Object in d)
            return value;

        return null;
    }
}
}
