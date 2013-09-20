/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/26/13
 * Time: 2:46 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.locale.core
{
public interface Parser
{
    function known(data:Object):Boolean;

    function parse(data:Object):Vector.<Bundle>;
}
}
