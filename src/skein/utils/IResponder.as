/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/24/13
 * Time: 3:13 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.utils
{
public interface IResponder
{
    function result(data:Object=null):void;

    function error(info:Object=null):void;
}
}
