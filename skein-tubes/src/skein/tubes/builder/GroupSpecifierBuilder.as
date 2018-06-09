/**
 * Created by max.rozdobudko@gmail.com on 6/8/18.
 */
package skein.tubes.builder {
import flash.net.GroupSpecifier;

import skein.core.skein_internal;

import skein.tubes.tube.Tube;

use namespace skein_internal;

public class GroupSpecifierBuilder {

    // Constructor

    public function GroupSpecifierBuilder(parent: TubeBuilder, tube: Tube) {
        super();
        _parent = parent;
        _tube = tube;
        _specifier = new GroupSpecifier(_tube.name);
    }

    // Variables

    private var _parent: TubeBuilder;

    private var _tube: Tube;

    private var _specifier: GroupSpecifier;

    // Builder

    public function ipMulticastMemberUpdatesEnabled(value: Boolean): GroupSpecifierBuilder {
        _specifier.ipMulticastMemberUpdatesEnabled = value;
        return this;
    }

    public function minGroupspecVersion(value: int): GroupSpecifierBuilder {
        _specifier.minGroupspecVersion = value;
        return this;
    }

    public function multicastEnabled(value: Boolean): GroupSpecifierBuilder {
        _specifier.multicastEnabled = value;
        return this;
    }

    public function objectReplicationEnabled(value: Boolean): GroupSpecifierBuilder {
        _specifier.objectReplicationEnabled = value;
        return this;
    }

    public function peerToPeerDisabled(value: Boolean): GroupSpecifierBuilder {
        _specifier.peerToPeerDisabled = value;
        return this;
    }

    public function postingEnabled(value: Boolean): GroupSpecifierBuilder {
        _specifier.postingEnabled = value;
        return this;
    }

    public function routingEnabled(value: Boolean): GroupSpecifierBuilder {
        _specifier.routingEnabled = value;
        return this;
    }

    public function serverChannelEnabled(value: Boolean): GroupSpecifierBuilder {
        _specifier.serverChannelEnabled = value;
        return this;
    }

    public function addIPMulticastAddress(address: String, port: * = null, source: String = null): GroupSpecifierBuilder {
        _specifier.addIPMulticastAddress(address, port, source);
        return this;
    }

    public function setPostingPassword(password: String, salt: String = null): GroupSpecifierBuilder {
        _specifier.setPostingPassword(password, salt);
        return this;
    }

    public function setPublishPassword(password: String, salt: String = null): GroupSpecifierBuilder {
        _specifier.setPublishPassword(password, salt);
        return this;
    }

    public function build(): TubeBuilder {
        _tube.connector.setSpecifier(_specifier);
        return _parent;
    }
}
}
