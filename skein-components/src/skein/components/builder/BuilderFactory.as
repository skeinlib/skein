/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/20/13
 * Time: 11:30 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.components.builder
{
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

public interface BuilderFactory
{
    function component(factory:Object):ComponentBuilder;

    function button(generator:Class=null):ButtonBuilder;

    function label(generator:Class = null):LabelBuilder;

    function input(generator:Class = null):TextInputBuilder;

    function textArea(generator:Class = null):TextAreaBuilder;

    function text(generator:Class = null):TextBuilder;

    function list(generator:Class=null):ListBuilder;

    function check(generator:Class=null):CheckBoxBuilder;

    function group(generator:Class = null):GroupBuilder;

    function vgroup(generator:Class = null):VGroupBuilder;

    function hgroup(generator:Class = null):HGroupBuilder;

    function image(generator:Class = null):ImageBuilder;

    function stepper():NumericStepperBuilder;

    function picker(generator:Class = null):PickerBuilder;
}
}
