/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/17/13
 * Time: 3:18 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.utils
{
public class StrongReference implements Reference
{
    public function StrongReference(value:Object)
    {
        super();

        _value = value;
    }

    private var _value:Object;

    public function get value():*
    {
        return _value;
    }
}
}
