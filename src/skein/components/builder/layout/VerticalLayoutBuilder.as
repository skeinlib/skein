/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/20/13
 * Time: 10:52 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.layout
{
import skein.components.builder.Builder;

public interface VerticalLayoutBuilder extends Builder
{
    function gap(value:Object):VerticalLayoutBuilder;

    function paddingLeft(value:Object):VerticalLayoutBuilder;

    function paddingTop(value:Object):VerticalLayoutBuilder;

    function paddingRight(value:Object):VerticalLayoutBuilder;

    function paddingBottom(value:Object):VerticalLayoutBuilder;

    function horizontalAlign(value:Object):VerticalLayoutBuilder;

    function verticalAlign(value:Object):VerticalLayoutBuilder;
}
}
