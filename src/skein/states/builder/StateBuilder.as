/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 5:13 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.states.builder
{
import skein.states.StateHolder;

public interface StateBuilder
{
    function base(state:String):StateBuilder;

    function part(id:Object):StateOverrideBuilder;

    function add(id:Object, instance:Object):StateOverrideBuilder;

    function remove(id:Object):StateOverrideBuilder;

    function build():StateHolder;
}
}
