/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 3/28/14
 * Time: 1:38 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.core
{
import skein.core.skein_internal;
import skein.rest.client.RestClient;

public class RestClientRegistry
{
    private static var repository:Array = [];

    public static function get():RestClient
    {
        var client:RestClient = repository.shift();

        if (client == null)
        {
            var RestClientImpl:Class =  Config.sharedInstance().getImplementation(RestClient);

            client = new RestClientImpl();
        }

        return client;
    }

    skein_internal static function clear():void
    {
        repository.length = 0;
    }

    skein_internal static function free(client:RestClient = null):void
    {
        if (repository.length < 2)
        {
            repository.push(client);
        }
    }
}
}
