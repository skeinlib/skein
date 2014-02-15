/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/25/13
 * Time: 11:08 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder.components
{
import skein.components.builder.Builder;
import skein.components.builder.BuilderFactory;

public interface ChildrenBuilder
{
    function build():GroupBuilder;
}
}
