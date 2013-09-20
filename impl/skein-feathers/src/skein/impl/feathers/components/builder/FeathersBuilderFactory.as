/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/20/13
 * Time: 11:31 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.impl.feathers.components.builder
{
import skein.components.builder.BuilderFactory;
import skein.components.builder.components.ButtonBuilder;
import skein.components.builder.components.CheckBoxBuilder;
import skein.components.builder.components.ComponentBuilder;
import skein.components.builder.components.GroupBuilder;
import skein.components.builder.components.HGroupBuilder;
import skein.components.builder.components.ImageBuilder;
import skein.components.builder.components.LabelBuilder;
import skein.components.builder.components.ListBuilder;
import skein.components.builder.components.NumericStepperBuilder;
import skein.components.builder.components.PickerBuilder;
import skein.components.builder.components.TextAreaBuilder;
import skein.components.builder.components.TextBuilder;
import skein.components.builder.components.TextInputBuilder;
import skein.components.builder.components.VGroupBuilder;
import skein.impl.feathers.components.builder.components.FeathersButtonBuilder;
import skein.impl.feathers.components.builder.components.FeathersCheckBoxBuilder;
import skein.impl.feathers.components.builder.components.FeathersComponentBuilder;
import skein.impl.feathers.components.builder.components.FeathersGroupBuilder;
import skein.impl.feathers.components.builder.components.FeathersHGroupBuilder;
import skein.impl.feathers.components.builder.components.FeathersImageBuilder;
import skein.impl.feathers.components.builder.components.FeathersLabelBuilder;
import skein.impl.feathers.components.builder.components.FeathersListBuilder;
import skein.impl.feathers.components.builder.components.FeathersNumericStepperBuilder;
import skein.impl.feathers.components.builder.components.FeathersPickerBuilder;
import skein.impl.feathers.components.builder.components.FeathersTextAreaBuilder;
import skein.impl.feathers.components.builder.components.FeathersTextBuilder;
import skein.impl.feathers.components.builder.components.FeathersTextInputBuilder;
import skein.impl.feathers.components.builder.components.FeathersVGroupBuilder;

public class FeathersBuilderFactory implements BuilderFactory
{
    public function FeathersBuilderFactory(host:Object)
    {
        super();

        this.host = host;
    }

    private var host:Object;

    public function button(generator:Class=null):ButtonBuilder
    {
        return new FeathersButtonBuilder(host, generator);
    }

    public function group(generator:Class = null):GroupBuilder
    {
        return new FeathersGroupBuilder(host, generator);
    }

    public function text(generator:Class = null):TextBuilder
    {
        return new FeathersTextBuilder(host, generator);
    }

    public function input(generator:Class = null):TextInputBuilder
    {
        return new FeathersTextInputBuilder(host, generator);
    }

    public function textArea():TextAreaBuilder
    {
        return new FeathersTextAreaBuilder(host);
    }

    public function vgroup(generator:Class = null):VGroupBuilder
    {
        return new FeathersVGroupBuilder(host, generator);
    }

    public function hgroup(generator:Class = null):HGroupBuilder
    {
        return new FeathersHGroupBuilder(host, generator);
    }

    public function check():CheckBoxBuilder
    {
        return new FeathersCheckBoxBuilder(host);
    }

    public function list(generator:Class = null):ListBuilder
    {
        return new FeathersListBuilder(host, generator);
    }

    public function image():ImageBuilder
    {
        return new FeathersImageBuilder(host);
    }

    public function label():LabelBuilder
    {
        return new FeathersLabelBuilder(host);
    }

    public function component(factory:Object):ComponentBuilder
    {
        return new FeathersComponentBuilder(host, factory);
    }

    public function stepper():NumericStepperBuilder
    {
        return new FeathersNumericStepperBuilder(host);
    }

    public function picker(generator:Class = null):PickerBuilder
    {
        return new FeathersPickerBuilder(host, generator);
    }
}
}
