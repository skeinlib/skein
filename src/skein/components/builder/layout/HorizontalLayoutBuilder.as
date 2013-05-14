/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/20/13
 * Time: 10:45 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.layout
{
public interface HorizontalLayoutBuilder extends LayoutBuilder
{
    function gap(value:Object):HorizontalLayoutBuilder;

    function paddingLeft(value:Object):HorizontalLayoutBuilder;

    function paddingTop(value:Object):HorizontalLayoutBuilder;

    function paddingRight(value:Object):HorizontalLayoutBuilder;

    function paddingBottom(value:Object):HorizontalLayoutBuilder;

    function horizontalAlign(value:Object):HorizontalLayoutBuilder;

    function verticalAlign(value:Object):HorizontalLayoutBuilder;
}
}
