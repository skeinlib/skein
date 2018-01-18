package skein.utils.delay {
import skein.utils.DelayUtil;

public function releaseTimeout(timeoutId: int): void {
    DelayUtil.releaseTimeout(timeoutId);
}
}