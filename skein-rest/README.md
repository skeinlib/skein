# skein-rest
ActionScript 3.0 fluent API for RESTful services.

## Dependencies
 * [skein-core](https://github.com/skeinlib/skein/skein-core)

## How To Use

#### Configuration

    Rest.config()
        .auth("http://example.com/oauth/v2")
        .configure()
        .rest("http://eaxmple.com/rest/api")
            .accessToken(get(this.tokens, "accessToken"))
        .configure();
        
#### Using
