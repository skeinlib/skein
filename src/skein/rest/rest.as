package skein.rest
{
import skein.rest.impl.rest.DefaultRestClient;
import skein.rest.rest.RestClient;

public function rest(api:String, ...params):RestClient
{
    return new DefaultRestClient(api, params);
}
}