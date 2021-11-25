const std = @import("std");

const zigHttpBuild = @import("deps/zig-http/build.zig");

pub fn build(b: *std.build.Builder) void
{
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});

    var tests = b.addTest("src/main.zig");
    tests.setBuildMode(mode);
    tests.setTarget(target);
    zigHttpBuild.addLib(tests, target, "deps/zig-http");

    const testStep = b.step("test", "Run library tests");
    testStep.dependOn(&tests.step);
}
