package skein.utils.delay
{
import flash.events.TimerEvent;
import flash.utils.Timer;

import skein.utils.DelayUtil;

public function delayToTimeout(timeout:uint, callback:Function, ...args):int
{
    args.unshift(callback);
    args.unshift(timeout);

    return DelayUtil.delayToTimeout.apply(null, args);
}
}