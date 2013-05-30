/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/17/13
 * Time: 3:37 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.complex.memory.binding
{
import flash.system.System;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;
import org.flexunit.async.Async;

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

public class BindingStaySiteStayHostStayTest
{
    public function BindingStaySiteStayHostStayTest()
    {
        super();
    }

    private var site:ISite;
    private var host:IHost;

    [Before]
    public function setup():void
    {
        this.site = new Site();
        this.host = new Host();
    }

    [After]
    public function teardown():void
    {
        this.site = null;
        this.host = null;
    }

    [Test]
    public function test():void
    {
        bind(set(site, "destination"), get(host, "source"));

        System.gc();

        Async.delayCall(this, check, 100);
    }

    private function check():void
    {
        assertNotNull(BindingGlobals.getBindings()[0].getSource());
    }
}
}
