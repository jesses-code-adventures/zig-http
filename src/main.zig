const std = @import("std");
const stdout = std.io.getStdOut().writer();
const server = @import("server/mod.zig");

pub fn main() !void {
    var s = try server.Server.init();
    try s.serve();
}
