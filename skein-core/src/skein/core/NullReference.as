/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/10/14
 * Time: 10:22 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.core
{
public class NullReference implements Reference
{
    public function NullReference()
    {
    }

    public function get value():*
    {
        return null;
    }
}
}
