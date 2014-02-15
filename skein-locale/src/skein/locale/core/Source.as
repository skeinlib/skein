/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/26/13
 * Time: 2:44 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.locale.core
{
import flash.events.IEventDispatcher;

public interface Source extends IEventDispatcher
{
    function isLoaded():Boolean;

    function getData():Object;

    function load():void;
}
}
