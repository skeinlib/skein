skein
=====

Skein is a set of libraries that help to build large application for projects where Flex could not be used. Originaly it  developed for use in mobile projects based on Starling framework with Feathers components.

Skein, in difference from Flex, is not a framework it is just a set of libraries that are independed of each other and could be attached to project separately.

skein-rest
----

Library for communication with Server through HTTP. It called _rest_-client because it is assumed to use it mostly for RESTful  API calls.

The goal is **reduce code** for client-server communication, **easy customization**, working **out of the box** for standard settings (HTTP+JSON).

```as3
rest("/employees/{0}", employeeId)
    .addHeader("Authorization", "basic-auth-string") 
    .contentType("application/xml") 
    .addParam("fullInfo", true)
    .decoder(employeeEncoder) 
    .result(resultHandler) 
    .error(errorHandler) 
.get();
```

skein-components
----
Provides fluent interface for build User Interface. It is not required a precompiler (unlike MXML), and not required any processing code (unlike solutions based on XML). It is just wrapper for setting properties of the components provided by concrete component library.

The goal is **reduce code** for view layout, support **data binding** for view components.

```as3
b.label().id("firstNameLabel")
    .styleName("settings-group-name-label")
.addTo();
b.input().id("firstNameInput")
    .height(35)
    .text(get(this, "model.user.firstName"))
    .softKeyboardType(SoftKeyboardType.DEFAULT)
    .autoCapitalize(AutoCapitalize.WORD)
    .on(Event.CHANGE, firstNameInput_changeHandler)
.addTo();
```

skein-binding
----
Data Binding library


skein-locale
----
UI Localization library

skein-popups
----
Provides fluent interface for creating popups. 

The goal is **reduce code** for working with popups.

```as3
attachPopup =
    Popups.newWrapper()
        .popup(AttachPopup)
        .modal(true).center(true).reuse(false)
        .position(PopupPosition.FILL)
        .onClosed(attachPopup_closedHandler)
    .build();
...
attachPopup.open = true;
```

skein-validators
----
This is a light-weight version of Cairngorms's validation library w/o dependecy on Flex.

The goal is **easy validation** for forms.

```as3
var usernameValidator:EmailValidator = new EmailValidator();
usernameValidator.source = usernameInput;
usernameValidator.property = "text";
validators.addValidator(usernameValidator);

var passwordValidator:PasswordValidator = new PasswordValidator();
passwordValidator.source = passwordInput;
passwordValidator.property = "text";
validators.addValidator(passwordValidator);

Validators.newSubscriberGroup()
    .addSubscriber()
        .listener(usernameInput)
        .validator(usernameValidator)
    .build()
    .addSubscriber()
        .listener(usernameInput)
        .validator(usernameValidator)
    .build()
.build();
```

skein-tubes
----
Easy API for RTMFP classes.
