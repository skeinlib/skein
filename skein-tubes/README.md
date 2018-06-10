# skein-tubes

A wrapper for Adobe Flash's RTMFP protocol implementation.

## Features

- [x] Builders with fluent interface for easy setup
- [x] Posting (send and receive messages using `NetGroup.post()` method)
- [x] Messaging (direct one-to-one and one-to-all messages)
- [x] Media (publish/subscribe to audio/video stream)
- [ ] Replication (sharing files)

## Basic concepts

* `Tube` provides access to all features of the one `NetGroup` instance, it takes `name` parameter in the constructor, this name is used later as `GroupSpecifier`'s name.
* `Connector` manages connections using `NetConnection` and `NetGroup` instances, it is an internal class that is not designed to be used directly.
* `Connection` is a tube's facet that provides methods for subscription to connetion related events.
* `Neighborhood` is a tube's facet that provides information about neighbors
* `Messaging` a tube's facet that is a facade for messaging features like sending direct message or emiting events to all neighbors.
* `Posting` a tube's facet that is a facade for `NetGroup.post()` functionality.
* `Broadcast` a tube's facet that is responsible for publishing audio/video streams.
* `Playback` a tube's facet that is responsible for playing audio/video streams.
* `Giver`/`Taker` under development, these tube's facets are responsible for sharing binary data.
* `Config` contains default settings 

## Usage

### Package-level functions

* `tubes(name)` a shortcut for creation an instance of `TubeBuilder` builder.
* `tube(name)` a shortcut to retrieving a `Tube` with specified name from registry.

### Configuration

Use `TubeBuilder` to configure one `Tube` instance. The next configuration creates serverless IP multicasting and immediately sends _Hi there!_ after conection established, all received messages will be printed in the output:

```as3
tubes("skein.tubes.test")
    .connection()
        .address("rtmfp:")
    .build()
    .specifier()
        .postingEnabled(true)
        .routingEnabled(true)
        .multicastEnabled(true)
        .addIPMulticastAddress("239.254.254.2:30304")
        .ipMulticastMemberUpdatesEnabled(true)
    .build()
.build();

tube("skein.tubes.test").posting.onMessage(function (message: Object): void {
    trace(message);
});

tube("skein.tubes.test").posting.send("Hi there!");
```

Use `ConfigBuilder` to set global configuration like `address`:

```as3
Tubes.config()
    .address("rtmfp://p2p.rtmfp.net/${stratus-dev-key}")
    .settings(myMediaSettings)
.build();
```

### Messaging

#### Direct message

```as3
var _tube: Tube = tube("skein.tubes.test");

// sends "Hi" message to first neighbor from the list
var to: String = _tube.neighborhood.neighbors[0];
_tube.messaging.send(to, "Hi");

// handles direct messages to this peer
_tube.messaging.onMessage(function (message: Object, sender: String, tube: Tube): void {
    trace(sender + ": " + message);
});
```

#### Emit event to all neighbors

```as3
var _tube: Tube = tube("skein.tubes.test");

// sends "Hi all" message to all neighbors 
_tube.messaging.emit("broadcast", "Hi all");

// prints received message for the "broadcast" event and sends "Hi" message back to sender.
_tube.messaging.on("broadcast", function(message: Object, sender: String, tube: Tube): void {
    trace(sender + ": " + message);
    tube.messaging.send(sender, "Hi");
});
```

### Posting

```as3
var _tube: Tube = tube("skein.tubes.test");

_tube.posting.send("Hi there!");

_tube.posting.onMessage(function (message: Object, sender: String, tube: Tube): void {
    trace(sender + ": " + message);
    tube.messaging.send(sender, "Hi");
});

```
