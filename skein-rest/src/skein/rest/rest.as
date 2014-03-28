package skein.rest
{
import skein.rest.client.RestClient;
import skein.rest.core.RestClientRegistry;

public function rest(api:String, ...params):RestClient
{
    var client:RestClient = RestClientRegistry.get();
    client.init(api, params);

    return client;
}
}