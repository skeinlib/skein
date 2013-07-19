/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/25/13
 * Time: 11:09 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder.components
{
import skein.components.builder.components.ButtonBuilder;
import skein.components.builder.components.CheckBoxBuilder;
import skein.components.builder.components.ChildrenBuilder;
import skein.components.builder.components.ComponentBuilder;
import skein.components.builder.components.GroupBuilder;
import skein.components.builder.components.HGroupBuilder;
import skein.components.builder.components.ImageBuilder;
import skein.components.builder.components.LabelBuilder;
import skein.components.builder.components.ListBuilder;
import skein.components.builder.components.NumericStepperBuilder;
import skein.components.builder.components.PickerBuilder;
import skein.components.builder.components.TextAreaBuilder;
import skein.components.builder.components.TextInputBuilder;
import skein.components.builder.components.VGroupBuilder;

public class FeathersChildrenBuilder implements ChildrenBuilder
{
    public function FeathersChildrenBuilder()
    {
    }

    public function button(generator:Class = null):ButtonBuilder
    {
        return null;
    }

    public function input(generator:Class = null):TextInputBuilder
    {
        return null;
    }

    public function check():CheckBoxBuilder
    {
        return null;
    }

    public function group():GroupBuilder
    {
        return null;
    }

    public function vgroup():VGroupBuilder
    {
        return null;
    }

    public function hgroup():HGroupBuilder
    {
        return null;
    }

    public function build():Object
    {
        return null;
    }

    public function addTo(host:Object = null):Object
    {
        return null;
    }

    public function list(generator:Class = null):ListBuilder
    {
        return null;
    }

    public function label():LabelBuilder
    {
        return null;
    }

    public function image():ImageBuilder
    {
        return null;
    }

    public function component(factory:Object):ComponentBuilder
    {
        return null;
    }

    public function textArea():TextAreaBuilder
    {
        return null;
    }

    public function stepper():NumericStepperBuilder
    {
        return null;
    }

    public function picker(generator:Class = null):PickerBuilder
    {
        return null;
    }
}
}
