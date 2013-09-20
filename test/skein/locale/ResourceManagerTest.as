/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 7/29/13
 * Time: 11:16 AM
 * To change this template use File | Settings | File Templates.
 */
package skein.locale
{
import flash.events.Event;

import mockolate.mock;
import mockolate.nice;

import mockolate.prepare;
import mockolate.verify;

import org.flexunit.assertThat;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNotNull;
import org.flexunit.asserts.assertNull;
import org.flexunit.async.Async;
import org.hamcrest.collection.hasItem;

import skein.locale.core.RawData;

import skein.locale.core.Source;

public class ResourceManagerTest
{
    public function ResourceManagerTest()
    {
    }

    [Before(async, timeout="500")]
    public function setUp():void
    {
        Async.proceedOnEvent(this, prepare(Source), Event.COMPLETE, 500);
    }

    [After]
    public function tearDown():void
    {

    }

    [Test]
    public function instance():void
    {
        assertNotNull(ResourceManager.instance);

        assertEquals(ResourceManager.instance, ResourceManager.instance);
    }

    [Test]
    public function getString():void
    {

    }

    [Test(async, timeout="500")]
    public function addSource():void
    {
        var source1:Source = nice(Source);

        mock(source1).method("isLoaded").returns(false);

        mock(source1).method("load").noArgs().dispatches(new Event(Event.COMPLETE), 10);

        mock(source1).method("getData").returns(new RawData("en_US", "bundle", null));

        var source2:Source = nice(Source);

        mock(source2).method("isLoaded").returns(true);

        mock(source2).method("getData").returns(new RawData("en_US", "bundle", null));

        ResourceManager.instance.addSource(source1);
        ResourceManager.instance.addSource(source2);

        verify(source2);

        Async.delayCall(this,
            function ():void
            {
                verify(source1);
            }
        , 100);
    }

    [Test]
    public function setLocale():void
    {
        ResourceManager.instance.setLocale("en_US");

        assertEquals("en_US", ResourceManager.instance.getLocales()[0]);
    }

    [Test]
    public function setLocales():void
    {

    }
}
}
