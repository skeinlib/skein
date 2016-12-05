# skein-rest
HTTP client written in ActionScript 3.0

## Features

 - [x] Fluent interface
 - [x] Loaders queue
 - [x] Friendly for large JSON/XML objects that culd be parsed asynchrounously (parsing should be done by your code)
 - [x] Cache in File System (AIR only ofcourse)
 - [x] Upload/download files
 - [x] Reusing responses (for two equal requests only one URLRequest will be used)
 - [x] Fully configurable (you can switch of all the features)
 - [x] Easy extensibility

## Dependencies

Being a part of skein library skein-rest depends on:

 * [skein-core](https://github.com/skeinlib/skein/master/skein-core) a glue library that connects parts of skein
 * [skein-utils](https://github.com/skeinlib/skein/master/skein-core) contains utility classes

These dependencies are merged into code during compilation and you can use only one `rest-skein.swc` file in your project.

## Objective

A classic way for communication with server-side through HTTP in AS3 using URLLoader is verbose, you have to write a lot of code for listening events from the URLLoader. Also the event model is one of most common causes of memory leaks, because it is so easy to forget add corresponded `removeEventListener` method, or add listener to `capture` phase and remove it from `target` one. So the main goal of `skein-rest` is to reduce code when woking with HTTP from AS3 projects and prevent mistakes with event listeners, but it also have some other benefits as caching or reusing responses.

## Overview

An HTTP client for AS3 projects supports four HTTP methods: `GET`, `POST`, `PUT` and `DELETE`. There are two usage aspects of this library, first is configuration that you usualy make once and second is requesting the data.

### Configuration

For configuration you use `RestConfig` implementation that is available from `Rest` class as follow:

```as3
Rest.config()
    .auth()
        .basic()
            .username(get(me, "username"))
            .password(get(me, "password"))
        .build()
    .build()
    .rest()
        .url("http://example.com/rest/api")
        .useCache(false)
        .useQueue(true)
    .build()
    .logger()
        .level(Log.DEBUG)
    .build();
```

As you can see it allows you to configure authorization through `auth()` method, REST API through `rest()` method and logging. Note that configuration step is complete optional, it just help you to write less code during data requesting phase.

### Data requesting

For make a request you use implementation of `RestClient` contract, that is available for you from `rest()` package level method, like this:

```as3
rest("/employees/{0}", employeeId)
    .contentType("application/xml") // set request content-type
    .addParam("fullInfo", true) // add URL parameters
    .result(resultHandler) // function called after parsing response takes Object instance as argument
    .error(errorHandler) // error handler received Error object
.post(employeeAsXML);
```

In this example you can see that `rest()` takes not full path to the endpoint, it is because it will get first part from the config. This is common usage of the skein-rest library, it aslo supports other configuration methods that will be discussed below but usual this is enough, even more by default it uses `application/json` mime-type for request so in most cases you ommit `.contentType("application/xml")` line.

### Configuration methods

#### URL Params

The URL parameters coul be added through `.addParam(key:String, value:Object)` method, like `fullInfo` in the next example:

```as3
rest("/employees/{0}", employeeId)
    .addParam("fullInfo", true)
.get();
```

This produces next URL `http://example.com/rest/api/employees/{EMPLOYEE_ID_VALUE}?fullInfo=true`

#### Access Token

You usualy use `.accessToken(value:String, key:String)` method during configuration that is shared between all requests, in this situation you might want to remove passing access token param to some endpoint, or override its name or you don't configure access token globally and want to pass it, in all this situations you use `.accessToken()` configuration method, like this: 

```as3
rest("/employees/{0}", employeeId)
    .accessToken("some-other-token", "accessToken")
.get()
```

**WARNING:** the `accessToken(value:String, key:String="access_token"):void` method defines value as first param, when `addParam(key:String, value:Object):void` define it as second. It makes possible to specify accessToken shorter, if parameter name is default value `access_token`.

#### ContentType

The `.contentType(value:String)` configuration method allows to specify content-type header for concrete request:

```as3
rest("/employees/{0}", employeeId)
    .contentType("application/xml")
.post(employeeAsXML);
```

Here you pass employee as XML document to server to update it, to help server understand that incoming data is XML you use `.contentType("application/xml")`.

**Defaults:** DefaultRestClient implementation uses `application/json` as default value for all requests.
    
#### Request Headers

The request headers could be specified for concrete request through `.addHeader(name:String, value:Object)` method:

```as3
rest("/employees/{0}", employeeId)
    .addHeader("Authorization", "basic-auth")
.get();
```

#### Encoder/Decoder

As you can pass and receive data throug this library, you need a way to serialize/deserialie your data. By default skein-rest serialize/deserialize objects to/from JSON using it's own JSON encoder/decoder. But you can override this, for example here we pass custom encoder/decoder:

```as3
rest("/employees")
    .encoder(employeeEncoder)
    .decoder(employeeDecoder)
.post(new Employee());
```

When you specify custom encoder or decoder you take responsibility to serialize data. The functions passsed here should have next signatures `encoder(data:Object, callback:Function)` and `decoder(data:Object, callback:Function)` encoder takes AS3 object as argument when decoder takes data received from server the signature for callback is `function(object:Object):void`. Each of them, after serialization task is done should call `callback` function and provide it with obtained value. For example `employeeEncoder` should be implemented like this:

```as3
function employeeEncoder(employee:Employee, callback:Function):void
{
    var dto:Object = 
    {
        id : employee.id,
        name : employe.displayName
    }
    
    callback(dto)
}
```
and `employeeDecoder`:

```as3
function employeeDecoder(jsonString:String, callback:Function):void
{
    var json:Object = JSON.parse(jsonString)
    
    var employee = new Employee()
    employee.id = json.id;
    employee.displayName = json.name; 
    
    callback(callback)
}
```

**NOTE:** as these methods takes callbacks to transmit their job, the serialization could be done asynchrounous, `RestClient` will wait until `callback` is called so you can add serialization of very large JSON w/o degradation UI performance.

#### Handlers

The `RestClient` implementation provides four handlers that you can use:

 * `.result()` for success responses, handler should have `function(data:Object, code:int):void` or `function(data:Object):void` or just `function():void`  signature
 * `.error()` for any error occurs, handler has `function(error:Error, code:int):void` or `function(error:Error):void` signature
 * `.progress()` for progress notifications, hanler has `function(bytesLoaded:Number, bytesTotal:Number):void` signature
 * `.status()` for handling HTTP status codes, handler's signature is `function(code:int):void`

You might like to use promises for handling error and result here, for example method for retrieving list of employees could look like:

```as3
public function getCannabinoids():Promise
{
    var deferred:Deferred = new Deferred();

    rest("/employees")
        .result(deferred.resolve)
        .error(deferred.reject)
    .get();

    return deferred.promise;
}
```

as you can see signatures of `Deferred` object are compatible with skein-rest.

#### Response Headers

You can also define a handler for response headers like this:

```as3
rest("/employees/{0}", employeeId)
    .header("X-Notice", xNoticeHandler)
.get();
```

The `xNoticeHandler` will be called everytime when `X-Notice` header is recevied in response. The handler's signature is `function(header:URLRequestHeader):void;`.

**WARNING:** This feature available only for AIR al long as [HTTP_RESPONSE_STATUS](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/events/HTTPStatusEvent.html#HTTP_RESPONSE_STATUS) available only for AIR.

### Features
TBD
