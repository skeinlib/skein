/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/17/13
 * Time: 2:30 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.complex.memory.binding
{
import flash.system.System;

import org.flexunit.asserts.assertEquals;
import org.flexunit.async.Async;
import org.flexunit.internals.runners.statements.SequencerWithDecoration;
import org.fluint.sequence.SequenceRunner;

import skein.binding.bind;
import skein.binding.core.BindingGlobals;
import skein.binding.get;
import skein.binding.set;
import skein.complex.data.Host;
import skein.complex.data.IHost;
import skein.complex.data.ISite;
import skein.complex.data.Site;
import skein.core.skein_internal;

use namespace skein_internal;

public class BindingStaySiteStayHostGoneTest
{
    private var site:ISite;

    [Before]
    public function setup():void
    {

    }

    [After]
    public function teardown():void
    {

    }

    [Test(async)]
    public function test():void
    {
        site = new Site();
        var host:IHost = new Host();

        bind(set(site, "destination"), get(host, "source"));

        Async.delayCall(this, check1, 100);
    }

    public function check1():void
    {
        assertEquals(1, BindingGlobals.getBindings().length);

        this.site = null;
        System.gc();

        Async.delayCall(this, check2, 100);
    }

    public function check2():void
    {
        assertEquals(0, BindingGlobals.getBindings().length);
    }
}
}
