/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 4/20/13
 * Time: 10:53 AM
 * To change this template use File | Settings | File Templates.
 */
package
{
import feathers.controls.Button;
import feathers.controls.TextInput;

import skein.Skein;

import starling.events.Event;

public class Test
{
    public var loginInput:TextInput;
    public var loginButton:Button;

    public function initialize():void
    {
        this.loginInput =
            Skein.input()
                .left(20).right(20).verticalCenter(-20)
                .on("change", function(event:Event):void
                    {
                        model.credentials.username = loginInput.text;
                    }
                )
            .build() as TextInput;

        this.loginButton =
            Skein.button
                .left(20).right(20).verticalCenter(20)
                .enabled(bind(property(this, "model.credentials.username")))
                .on(Event.TRIGGERED, this.model.login)
            .build() as Button;

        Skein.group()
            .x(0).y(0).width(this.width).height(this.height)
            .contain(
                this.loginInput,
                this.loginButton
            )
            .build()

        Skein.group()
            .x(0).y(0).width(this.width).height(this.height)
            .contain(
                input()
                    .left(20).right(20).verticalCenter(-20)
                    .on(Event.CHANGE, function(event:Event):void
                        {
                            model.credentials.username = loginInput.text;
                        }
                    )
                .build(),
                button()
                    .left(20).right(20).verticalCenter(20)
                    .enabled(bind(property(this, "model.credentials.username")))
                    .on(Event.TRIGGERED, this.model.login)
                .build()
            )
            .addTo(this)
    }
}
}
