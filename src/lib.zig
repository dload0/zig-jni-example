const std = @import("std");
const jni = @import("jni");

/// This function is called from the Java side.
pub fn bootstrap(env: *jni.cjni.JNIEnv, _: jni.jclass) callconv(.C) void {
    // Print debug.
    std.debug.print("[ ! ] `Java_dev_dload_NativeLoader_bootstrap` called.\n", .{});

    // Warp the env into the wrapper.
    _ = jni.JNIEnv.warp(env);
}
