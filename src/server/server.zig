const std = @import("std");
const net = @import("std").net;

pub const Server = struct {
    _socket: Socket,

    pub fn init() !Server {
        const socket = try Socket.init();       
        return Server{ ._socket = socket };
    }

    pub fn serve(self: *Server) !void {
        var listener = try self._socket._address.listen(.{});
        while (true) {
            var conn = try listener.accept();
            try handleConnection(&conn);
        }
    }
};

const Socket = struct {
    _address: std.net.Address,
    _stream: std.net.Stream,
    fn init() !Socket {
        const host = [4]u8{ 127, 0, 0, 1 }; // localhost
        const port: u16 = 42069;
        const addr = std.net.Address.initIp4(host, port);
        const socket = try std.posix.socket(
            addr.any.family,
            std.posix.SOCK.STREAM,
            std.posix.IPPROTO.TCP,
        );
        const stream = std.net.Stream{ .handle = socket };
        return Socket{ ._address = addr, ._stream = stream };
    }
};


fn handleConnection(conn: *net.Server.Connection) !void {
    defer conn.stream.close();
    var buffer: [1024]u8 = undefined;
    const read_bytes = try conn.stream.read(buffer[0..]);
    std.debug.print("received: {s}\n", .{buffer[0..read_bytes]});
    const response = "HTTP/1.1 200 OK\r\nContent-Length: 5\r\n\r\nHello";
    try conn.stream.writeAll(response);
    std.debug.print("response sent\n", .{});
}
