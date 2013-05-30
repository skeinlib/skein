/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/17/13
 * Time: 1:59 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.complex.memory
{
import skein.complex.memory.binding.BindingGoneSiteHostSameGoneTest;
import skein.complex.memory.binding.BindingGoneSiteGoneHostGoneTest;
import skein.complex.memory.binding.BindingStaySiteStayHostGoneTest;

[Suite]
[RunWith("org.flexunit.runners.Suite")]
public class PreventMemoryLeaksTests
{
    public var bindingGoneSiteGoneHostGone:BindingGoneSiteGoneHostGoneTest;
    public var bindingStaySiteStayHostGone:BindingStaySiteStayHostGoneTest;
    public var bindingGoneSiteHostSameGone:BindingGoneSiteHostSameGoneTest;
}
}
