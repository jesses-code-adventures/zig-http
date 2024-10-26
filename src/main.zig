const std = @import("std");
const stdout = std.io.getStdOut().writer();
const request = @import("request/mod.zig");

pub fn main() void {
    const req = request.Request{
        .headers = undefined,
        .body = "hello!",
    };
    stdout.print("request body: {s}\n", .{req.body}) catch {};
}

