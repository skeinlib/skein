/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/30/13
 * Time: 2:03 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.core
{
public interface Destination
{
    function setSite(site:Object):void;
    function getSite():Object;

    function setValue(value:*):void;

    function getMember():String;
}
}
