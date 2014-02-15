/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/17/13
 * Time: 7:57 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.rest.builder
{
public class ConfigBuilder
{
    function ConfigBuilder()
    {
        super();
    }

    public function auth(url:String):AuthConfigBuilder
    {
        return new AuthConfigBuilder(this, url);
    }

    public function rest(url:String):RestConfigBuilder
    {
        return new RestConfigBuilder(this, url);
    }
}
}
