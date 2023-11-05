const std = @import("std");
const Room = @import("src/domain/Room.zig").Room;
const Maze = @import("src/domain/Maze.zig").Maze;
const Directions = @import("./src/domain/enum/Directions.zig").Directions;
const Limits = @import("./src/domain/enum/Limits.zig").Limits;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    var room = try Room.init();
    try stdout.print("Is room open? {} \n", .{room.isOpen()});
    try room.rebuildWall(Directions.NORTH, Limits.VOID);
    try stdout.print("Is room open? {} \n", .{room.isOpen()});
    var maze = try Maze.init(10, 10);
    _ = maze;
}
