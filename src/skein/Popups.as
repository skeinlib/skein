/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/19/13
 * Time: 4:08 PM
 * To change this template use File | Settings | File Templates.
 */
package skein
{
import skein.popups.builder.PopupWrapperBuilder;

public class Popups
{
    private static var wrapperBuilderFactory:Class;

    public static function setWrapperBuilderFactory(value:Class):void
    {
        wrapperBuilderFactory = value;
    }

    public static function newWrapper():PopupWrapperBuilder
    {
        return new wrapperBuilderFactory();
    }
}
}
