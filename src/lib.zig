const std = @import("std");
const jni = @import("jni");

/// This function is called from the Java side.
pub fn bootstrap(_: *jni.JNIEnv, _: jni.jclass) callconv(.C) void {
    // Print debug.
    std.debug.print("[ ! ] `Java_dev_dload_NativeLoader_bootstrap` called.\n", .{});
}
