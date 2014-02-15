/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/21/13
 * Time: 2:07 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.binding.core
{
public class SourceBase implements Source
{
    public function SourceBase()
    {
    }

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
        if (this.callback)
        {
            switch (this.callback.length)
            {
                case 0 : this.callback(); break;
                case 1 : this.callback(getValue()); break;
            }
        }
    }

    public function dispose():void {}

    public function toString():String
    {
        return String(getValue());
    }
}
}
