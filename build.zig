const std = @import("std");

/// Define an array of target architectures and operating systems for the build.
const targets: []const std.Target.Query = &.{
    .{ .cpu_arch = .aarch64, .os_tag = .windows },
    .{ .cpu_arch = .aarch64, .os_tag = .linux },
    .{ .cpu_arch = .aarch64, .os_tag = .macos },
    .{ .cpu_arch = .x86_64, .os_tag = .windows },
    .{ .cpu_arch = .x86_64, .os_tag = .linux, .abi = .gnu },
    .{ .cpu_arch = .x86_64, .os_tag = .linux, .abi = .musl },
    .{ .cpu_arch = .x86_64, .os_tag = .macos },
};

/// Name of the shared library native.
const lib_name = "zig_jni_native_example";

/// Build function to configure the build process.
pub fn build(b: *std.Build) !void {
    // Add a dependency on the JNI module.
    const dep_JNI = b.dependency("JNI", .{}).module("JNI");

    for (targets) |t| {
        // Create a shared library for the current target.
        const lib = b.addSharedLibrary(.{
            .name = lib_name,
            .root_source_file = b.path("src/root.zig"),
            .target = b.resolveTargetQuery(t),

            // Set optimization level
            .optimize = .ReleaseSmall,
        });

        // Add the JNI module as an import to the library's root module.
        lib.root_module.addImport("jni", dep_JNI);

        // Add an install artifact for the shared library.
        const target_output = b.addInstallArtifact(lib, .{
            .dest_dir = .{
                // Override the destination directory to split targets up.
                .override = .{
                    .custom = try t.zigTriple(b.allocator),
                },
            },
        });

        // Ensure the install step depends on the output artifact.
        b.getInstallStep().dependOn(&target_output.step);
    }
}
