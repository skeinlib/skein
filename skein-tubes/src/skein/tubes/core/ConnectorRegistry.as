/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 12/26/13
 * Time: 5:35 PM
 * To change this template use File | Settings | File Templates.
 */
package skein.tubes.core
{
import flash.utils.Dictionary;

import skein.core.skein_internal;

use namespace skein_internal;

public class ConnectorRegistry
{
    private static var references:Dictionary;

    private static var connectors:Dictionary;

    public static function retainConnector(name: String): Connector {
        var connector: Connector = getExisting(name) || createNew(name);

        if (references == null) {
            references = new Dictionary(true);
        }

        if (references[connector]) {
            references[connector]++;
        } else {
            references[connector] = 1;
        }

        return connector;
    }

    public static function releaseConnector(connector: Connector): void {
        if (!references[connector]) {
            return;
        }

        references[connector]--;

        if (references[connector] == 0) {
            connector.dispose();
        }
    }

    private static function createNew(name:String):Connector
    {
        if (!connectors)
            connectors = new Dictionary(true);

        var connector:Connector = new Connector(name);

        connectors[connector] = name;

        return connector;
    }

    public static function getExisting(name:String):Connector
    {
        if (!connectors) return null;

        for (var s:* in connectors)
        {
            if (connectors[s] == name)
                return s;
        }

        return null
    }
}
}
