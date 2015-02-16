/**
 * Created by mobitile on 12/18/14.
 */
package skein.rest.errors
{
public class DataProcessingError extends Error
{
    public function DataProcessingError(message:* = "", id:* = 0)
    {
        super(message, id);
    }
}
}
