/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/21/13
 * Time: 2:07 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.core
{
import skein.core.NullReference;
import skein.core.Reference;
import skein.core.WeakReference;

public class SourceBase implements Source
{
    public function SourceBase(host:Object)
    {
        super();

        this.host = host ? new WeakReference(host) : new NullReference();
    }

    protected var host:Reference;

    protected var callback:Function;

    public function setCallback(value:Function):void
    {
        callback = value;
    }

    public function getValue():Object
    {
        return null;
    }

    protected function handler():void
    {
        if (this.host.value != null)
        {
            if (this.callback)
            {
                switch (this.callback.length)
                {
                    case 0 : this.callback(); break;
                    case 1 : this.callback(getValue()); break;
                }
            }
        }
        else
        {
            this.dispose();
        }
    }

    public function dispose():void {}

    public function toString():String
    {
        return String(getValue());
    }
}
}
