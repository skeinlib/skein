/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 5/17/13
 * Time: 2:01 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.complex.memory.binding
{
import flash.system.System;

import org.flexunit.assertThat;
import org.flexunit.asserts.assertEquals;

import org.flexunit.asserts.assertNull;

import org.flexunit.async.Async;
import org.hamcrest.collection.emptyArray;

import skein.binding.bind;
import skein.binding.core.Binding;
import skein.binding.core.BindingGlobals;
import skein.binding.get;
import skein.binding.set;
import skein.complex.data.Host;
import skein.complex.data.IHost;
import skein.complex.data.ISite;
import skein.complex.data.Site;
import skein.core.skein_internal;
import skein.utils.WeakReference;

use namespace skein_internal;

public class BindingGoneSiteGoneHostGoneTest
{
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
        var host:IHost = new Host();
        var site:ISite = new Site();

        bind(set(site, "destination"), get(host, "source"));

        System.gc();

        Async.delayCall(this, check, 100);
    }

    public function check():void
    {
        assertEquals(0, BindingGlobals.getBindings().length);
    }
}
}
