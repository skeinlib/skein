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
import skein.components.builder.components.TextInputBuilder;
import skein.components.builder.components.VGroupBuilder;

public interface BuilderFactory
{
    function component(factory:Object):ComponentBuilder;

    function button(generator:Class=null):ButtonBuilder;

    function label():LabelBuilder;

    function input(generator:Class = null):TextInputBuilder;

    function textArea():TextAreaBuilder;

    function list(generator:Class=null):ListBuilder;

    function check():CheckBoxBuilder;

    function group():GroupBuilder;

    function vgroup():VGroupBuilder;

    function hgroup():HGroupBuilder;

    function image():ImageBuilder;

    function stepper():NumericStepperBuilder;

    function picker(generator:Class = null):PickerBuilder;
}
}
