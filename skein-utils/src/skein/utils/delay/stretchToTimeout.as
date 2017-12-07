package skein.utils.delay {
import skein.utils.DelayUtil;

public function stretchToTimeout(timeout: uint, callback: Function, ...args): void {
    args.unshift(callback);
    args.unshift(timeout);
    DelayUtil.stretchToTimeout.apply(null, args);
}
}