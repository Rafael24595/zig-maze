const std = @import("std");
const Room = @import("src/domain/Room.zig").Room;
const Maze = @import("src/domain/Maze.zig").Maze;
const Directions = @import("./src/domain/enum/Directions.zig").Directions;
const Limits = @import("./src/domain/enum/Limits.zig").Limits;

const Optional = @import("src/commons/Optional.zig").Optional;
const Configurator = @import("src/commons/configuration/Configurator.zig").Configurator;
const Random = @import("src/commons/random/Random.zig").Random;

pub fn main() !void {
    _ = try Configurator.configure();

    const stdout = std.io.getStdOut().writer();
    var room = try Room.init();
    try stdout.print("Is room open? {} \n", .{room.isOpen()});
    try room.rebuildWall(Directions.NORTH, Limits.VOID);
    try stdout.print("Is room open? {} \n", .{room.isOpen()});
    var maze = try Maze.init(10, 10);
    _ = maze;

    var random = try Random.getInstance();
    for (0..5) |_| {
        var some_random_num = random.integerRange(u8, 0, 10);
        std.debug.print("random number is {} \n", .{some_random_num});
    }

    const x = Optional(i8).some(10);
    std.debug.print("Is some? {} \n", .{x.isSome()});
    std.debug.print("Value? {} \n", .{try x.unwrap()});
}
