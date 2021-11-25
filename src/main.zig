const std = @import("std");
const testing = std.testing;

const client = @import("http-client");

pub fn doStuff(allocator: *std.mem.Allocator) !void
{
    var outData = std.ArrayList(u8).init(allocator);
    var response: client.Response = undefined;
    try client.httpGet("www.google.com", "/", null, allocator, &outData, &response);
}

export fn add(a: i32, b: i32) i32
{
    return a + b;
}

test "basic add functionality"
{
    try testing.expect(add(3, 7) == 10);
}

test "do the stuff"
{
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        if (!gpa.deinit()) {
            std.log.err("gpa deinit failed", .{});
        }
    }

    try doStuff(&gpa.allocator);
}