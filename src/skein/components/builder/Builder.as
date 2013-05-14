/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/19/13
 * Time: 5:02 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder
{
public interface Builder
{
    function build():Object;

    function addTo(host:Object = null):Object;
}
}
