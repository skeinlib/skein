/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/23/13
 * Time: 5:11 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.states.transition
{
import skein.states.Override;
import skein.states.State;

public class StateTransition
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function StateTransition(host:Object, from:State, to:State)
    {
        super();

        this.host = host;
        this.from = from;
        this.to = to;
    }

    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var host:Object;
    private var from:State;
    private var to:State;

    private var completeHandler:Function;
    private var errorHandler:Function;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function perform():void
    {
        this.removeState(this.from);

        this.applyState(this.to);

        if (this.completeHandler != null)
            this.completeHandler();
    }

    //--------------------------------------
    //  Methods: Internal
    //--------------------------------------

    private function applyState(state:State):void
    {
        for (var i:int = 0, n:int = state.numOverrides(); i < n; i++)
        {
            var o:Override = state.getOverrideAt(i);

            try
            {
                o.apply(this.host);
            }
            catch (error:Error)
            {
                if (this.errorHandler != null)
                    this.errorHandler(error);
                else
                    throw error;
            }
        }
    }

    private function removeState(state:State):void
    {
        for (var i:int = 0, n:int = state.numOverrides(); i < n; i++)
        {
            var o:Override = state.getOverrideAt(i);

            try
            {
                o.remove(this.host);
            }
            catch (error:Error)
            {
                if (this.errorHandler != null)
                    this.errorHandler(error);
                else
                    throw error;
            }
        }
    }

}
}
