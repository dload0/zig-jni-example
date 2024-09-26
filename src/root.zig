const std = @import("std");
const jni = @import("jni");

comptime {
    // Exports any public functions from the imported function struct as Java JNI name qualified.
    jni.exportJNI("dev.dload.NativeLoader", @import("lib.zig"));
}

/// This function is called when the JVM loads the native library.
export fn JNI_OnLoad(vm: *jni.cjni.JavaVM, _: ?*anyopaque) callconv(.C) jni.jint {
    // Warp the VM into the wrapper.
    const warped_vm = @constCast(&jni.JavaVM.warp(vm));

    // JNIEnv pointer.
    var env: jni.JNIEnv = undefined;

    // Call getEnv to retrieve the JNIEnv pointer.
    _ = warped_vm.getEnv(&env, @intFromEnum(jni.JNIVersion.JNI1_6)) catch blk: {
        break :blk undefined;
    };

    // Print debug.
    std.debug.print("[ ! ] `JNI_OnLoad` called.\n", .{});

    // Return the JNI version that is supported.
    return @intFromEnum(jni.JNIVersion.JNI1_6);
}
