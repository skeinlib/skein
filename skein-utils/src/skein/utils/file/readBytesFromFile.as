package skein.utils.file {
import skein.utils.FileUtil;

public function readBytesFromFile(file: Object, callback: Function): void {
    if (FileUtil.isSupported) {
        FileUtil.readBytes(file, callback);
    } else {
        callback(new Error("FileUtil is not supported on this platform."));
    }
}
}