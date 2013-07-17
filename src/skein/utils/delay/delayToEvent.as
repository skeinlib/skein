package skein.utils.delay
{
public function delayToEvent(dispatcher:Object, event:String, callback:Function, ...args):void
{
    dispatcher.addEventListener(event,
        function handler(e:Object):void
        {
            dispatcher.removeEventListener(event, handler);

            callback.apply(null, args);
        }
    );
}
}