/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/16/13
 * Time: 2:18 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.core
{
import flash.events.Event;

import mockolate.mock;

import mockolate.nice;
import mockolate.prepare;
import mockolate.stub;

import org.flexunit.async.Async;
import org.hamcrest.core.isA;

public class OperatorBaseTest
{
    public function OperatorBaseTest()
    {
        super()
    }

    [Before(async, timeout=500)]
    public function setUp():void
    {
        Async.proceedOnEvent(this, prepare(Source), Event.COMPLETE);
    }

    [Test]
    public function setCallback():void
    {

    }

    [Test]
    public function setOperands():void
    {
        var operand:SourceBase = nice(Source);

        mock(operand).method("setCallback").args(isA(Function));



        var callback:Function = function():void
        {

        }

        var operator:OperatorBase = new OperatorBase();

        operator.setOperands([operand]);


    }

    [Test]
    public function getValue():void
    {

    }

    [Test]
    public function handler():void
    {

    }

    [Test]
    public function dispose():void
    {

    }
}
}
