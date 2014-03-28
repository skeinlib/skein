# skein-rest
ActionScript 3.0 fluent API for RESTful services.

## Dependencies
 * [skein-core](https://github.com/skeinlib/skein/skein-core)

### Configuration

    Rest.config()
        .rest("http://eaxmple.com/rest/api")
            .accessToken("access-token")
        .configure();

You pass a root URL of the API to the `rest()` function, library stores it so you can omit it for next usage. 
If you pass your acces-token to the `accessToken()` method it will be used for all requests, but you can specify other for concrete request.
        
### Simple Usage

Next gets Employee by id:

    rest("/employees/{0}", employeeId)
        .result(completeHandler)
        .error(errorHandler)
    .get();
    
Note that result URL will be `http://exaple.com/rest/api` + `/employee/{employeeId}`
    
#### URL Params

You can specify URL parameters like this:

    rest("/employees/{0}, employeeId)
        .addParam("fullInfo", true)
    .get();

This produces next URL `http://example.com/rest/api/employees/{employeeId}?fullInfo=true`

To override default acces-token:
    
    rest("/employees/{0}, employeeId)
        .accessToken("some-other-token", "accessToken")
    .get()

Note that `accessToken(value:String, key:String="access_token"):void` defines value as first param, when `addParam(key:String, value:Object):void` define it as second. It makes possible to specify accessToken shorter, if parameter name is default value `access_token`.

#### Encoder/Decoder

As you can pass and receive data throug this library, you need a way to serialize/deserialie your data. By default skein-rest serialize/deserialize objects to/from JSON using it's own JSON encoder/decoder. But you can override this, for example here we pass custom encoder/decoder:

    rest("/employees)
        .encoder(employeeEncoder)
        .decoder(employeeDecoder)
    .post(new Employee());
    
#### Handlers

The next four handlers are suported: 

    rest("/employees/{0}", employeeId)
        .result(completeHandler)
        .error(errorHandler)
        .progress(progressHandler)
        .staus(statusHandler)
    .get();

The result handler's signature is `resultHandler(data:Object, code:int):void`. Similarly error handler's singature is `errorHandler(error:Error, code:int):void`. The second argument for both these handlers is *optional*, it means you can define your handler with one argument only. The status handler's signature is `statusHandler(code:int):void` the `code` for all of these handlers is response code received from server. The last progress hander's signature is `progressHandler(bytesLoaded:Number, bytesTotal:Number):void`

