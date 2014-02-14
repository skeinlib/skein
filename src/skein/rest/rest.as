package skein.rest
{
import skein.rest.client.impl.DefaultRestClient;
import skein.rest.client.RestClient;

public function rest(api:String, ...params):RestClient
{
    return new DefaultRestClient(api, params);
}
}