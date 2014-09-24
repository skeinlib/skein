# skein-rest
Rest Client for ActionScript 3.0 with fluent interface. In fact this library is a wrapper for standard `URLLoader`.

## Dependencies
 * [skein-core](https://github.com/skeinlib/skein/skein-core)

### Supported HTTP Methods

Four HTTP methods are supported: `GET`, `POST`, `PUT` and `DELETE` throught corresponded RestClient's metods: `get():void`, `post(data:Object=null):void`, `put(data:Object=null):void` and `del(data:Object=null)`.

### Configuration

```as3
Rest.config()
    .rest("http://eaxmple.com/rest/api")
        .accessToken("access-token")
    .configure();
```

You pass a root URL of the API to the `rest()` function, library stores it so you can omit it for next usage. 
If you pass your acces-token to the `accessToken()` method it will be used for all requests, but you can specify other for concrete request.

### Usage

```as3
rest("/employees/{0}", employeeId)
    .addHeader("Authorization", "basic-auth-string") // adds request header
    .contentType("application/xml") // sets content-type 
    .addParam("fullInfo", true) // adds URL parameters
    .decoder(employeeEncoder) // deserialization function
    .result(resultHandler) // complete handerl
    .error(errorHandler) // error handler
.get();
```
    
Note that the result URL for this response will be:

`http://exaple.com/rest/api` + `/employees/{employeeId}` + `?` + `fullInfo=true` + `&` + `access_token={acces-token}`

#### Request Headers

The request headers could be specified for concrete request through ``RestClient.addHeader(name:String, value:Object)` method:

```as3
rest("/employees/{0}", employeeId)
    .addHeader("Authorization", "basic-auth")
.get();
```

#### ContentType

The `RestClient.contentType(value:String)` method allows to specify content-type header for concrete request. 

**Defaults:** RestClient uses `application/json` as default value for all requests.
    
#### URL Params

The URL parameters coul be added like this:

```as3
rest("/employees/{0}, employeeId)
    .addParam("fullInfo", true)
.get();
```

This produces next URL `http://example.com/rest/api/employees/{employeeId}?fullInfo=true`

Uou can override default (specified during configuration) acces-token:
    
```as3
rest("/employees/{0}, employeeId)
    .accessToken("some-other-token", "accessToken")
.get()
```

Note that `accessToken(value:String, key:String="access_token"):void` defines value as first param, when `addParam(key:String, value:Object):void` define it as second. It makes possible to specify accessToken shorter, if parameter name is default value `access_token`.

#### Encoder/Decoder

As you can pass and receive data throug this library, you need a way to serialize/deserialie your data. By default skein-rest serialize/deserialize objects to/from JSON using it's own JSON encoder/decoder. But you can override this, for example here we pass custom encoder/decoder:

```as3
rest("/employees)
    .encoder(employeeEncoder)
    .decoder(employeeDecoder)
.post(new Employee());
```
    
#### Handlers

The next four handlers are suported: 

```as3
rest("/employees/{0}", employeeId)
    .result(completeHandler)
    .error(errorHandler)
    .progress(progressHandler)
    .staus(statusHandler)
.get();
```

The result handler's signature is `resultHandler(data:Object, code:int):void`. Similarly error handler's singature is `errorHandler(error:Error, code:int):void`. The second argument for both these handlers is *optional*, it means you can define your handler with one argument only. The status handler's signature is `statusHandler(code:int):void` the `code` for all of these handlers is response code received from server. The last progress hander's signature is `progressHandler(bytesLoaded:Number, bytesTotal:Number):void`

#### Response Headers

You can define a handler for response header:

```as3
rest("/employees/{0}", employeeId)
    .header("X-Notice", xNoticeHandler)
.get();
```

The `xNoticeHandler` will be called everytime when `RestClient` recevies `X-Notice` header in response. The handler's signature is `xNoticeHandler(header:URLRequestHeader):void;`.

**Note:** This feature available only for AIR al long as [HTTP_RESPONSE_STATUS](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/events/HTTPStatusEvent.html#HTTP_RESPONSE_STATUS) available only for AIR.
