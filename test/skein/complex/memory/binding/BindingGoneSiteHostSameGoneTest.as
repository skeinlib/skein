/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/17/13
 * Time: 3:07 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.complex.memory.binding
{
import flash.system.System;

import org.flexunit.asserts.assertEquals;
import org.flexunit.async.Async;

import skein.binding.bind;
import skein.binding.core.BindingGlobals;
import skein.binding.get;
import skein.binding.set;

import skein.complex.data.HostAndSite;
import skein.complex.data.IHost;
import skein.complex.data.ISite;
import skein.core.skein_internal;

use namespace skein_internal;

public class BindingGoneSiteHostSameGoneTest
{
    public function BindingGoneSiteHostSameGoneTest()
    {
    }

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
        var host:IHost = new HostAndSite();

        bind(set(host, "destination"), get(host, "source"));

        System.gc();

        Async.delayCall(this, check, 100);
    }

    private function check():void
    {
        assertEquals(0, BindingGlobals.getBindings().length);
    }
}
}
