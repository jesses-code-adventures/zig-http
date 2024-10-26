const std = @import("std");
const stdout = std.io.getStdOut().writer();

// TODO: fill these out
const MimeType = enum {
    json,
    text,
    pub fn text(self: MimeType) []const u8 {
        switch (self) {
            self.json => {
                return "application/json";
            },
            self.html => {
                return "text/html";
            },
        }
    }
};

pub fn parseMimeType(s: []const u8) !MimeType {
    if (std.mem.eql(s, "application/json")) {
        return MimeType.json;
    } else if (std.mem.eql(s, "text/html")) {
        return MimeType.html;
    } else {
        return error.InvalidMimeType;
    }
}

const Header = struct {
    content_length: usize,
    content_type: MimeType,
};

pub fn main() !void {
    const string_object = "hello muthafuckas what up";
    try stdout.print("{d}", .{string_object.len});
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // Try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

test "fuzz example" {
    // Try passing `--fuzz` to `zig build` and see if it manages to fail this test case!
    const input_bytes = std.testing.fuzzInput(.{});
    try std.testing.expect(!std.mem.eql(u8, "canyoufindme", input_bytes));
}
