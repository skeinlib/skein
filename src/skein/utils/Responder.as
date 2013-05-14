/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/24/13
 * Time: 3:16 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.utils
{
public class Responder implements IResponder
{
    public function Responder(result:Function, error:Function)
    {
        super();

        this.resultHandler = result;
        this.errorHandler = error;
    }

    private var resultHandler:Function;
    private var errorHandler:Function;

    public function result(data:Object = null):void
    {
        if (this.resultHandler != null)
            this.resultHandler(data);
    }

    public function error(info:Object = null):void
    {
        if (this.errorHandler != null)
            this.errorHandler(info);
    }
}
}
