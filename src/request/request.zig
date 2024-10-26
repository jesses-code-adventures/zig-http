const std = @import("std");

/// Note that this is unavailable in HTTP2 & HTTP3.
const RequestConnectionOption = enum {
    proxy_connection,
    keep_alive,
    transfer_encoding,
    upgrade,
    empty,
};

/// Used for Accept and ContentType headers
const MimeType = enum {
    json,
    html,
    empty,
    pub fn text(self: MimeType) []const u8 {
        switch (self) {
            self.json => {
                return "application/json";
            },
            self.html => {
                return "text/html";
            },
            self.empty => {
                return "";
            },
        }
    }
};

pub fn parseMimeType(s: []const u8) MimeType {
    if (std.mem.eql(s, "application/json")) {
        return MimeType.json;
    } else if (std.mem.eql(s, "text/html")) {
        return MimeType.html;
    } else {
        return MimeType.empty;
    }
}

pub const RequestHeaders = struct {
    accept: MimeType,
    accept_encoding: [][]const u8, // TODO: make this an actual type
    content_type: MimeType,
    content_length: usize,
    host: []const u8,
    referer: []const u8,
    user_agent: []const u8,
};

/// Represents an incoming HTTP request
pub const Request = struct {
    headers: RequestHeaders,
    body: []const u8,
};
