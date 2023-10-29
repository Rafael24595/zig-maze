const std = @import("std");
const Room = @import("src/domain/Room.zig").Room;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const room = try Room.init();
    try stdout.print("Is room open? {}", .{room.isOpen()});
}
