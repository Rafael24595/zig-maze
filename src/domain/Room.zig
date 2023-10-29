const std = @import("std");
const Directions = @import("./enum/Directions.zig").Directions;
const Limits = @import("./enum/Limits.zig").Limits;

pub const Room = struct {

    const Self = @This();

    map: std.AutoHashMap(Directions, Limits),
    isPrincipal: bool,

    pub fn init()std.mem.Allocator.Error!Room {
        return Room{
            .map = try fill(),
            .isPrincipal = false
        };
    }

    fn fill() std.mem.Allocator.Error!std.AutoHashMap(Directions, Limits) {
        var gpa = std.heap.GeneralPurposeAllocator(.{}){};
	    const allocator = gpa.allocator();
        var map: std.AutoHashMap(Directions, Limits) = std.AutoHashMap(Directions, Limits).init(allocator);
        try map.put(Directions.NORTH, Limits.WALL);
        try map.put(Directions.SOUTH, Limits.WALL);
        try map.put(Directions.EAST, Limits.WALL);
        try map.put(Directions.WEST, Limits.WALL);
        return map;
    }

    pub fn isPrincipalRoute(self: Self) bool {
        return self.isPrincipal;
    }

    pub fn isOpen(self: Self) bool {
        var iterator = self.map.iterator();
        while (iterator.next()) |entry| {
            const key = entry.key_ptr;
            const value = entry.value_ptr;
            std.debug.print("{}: {}\n", .{key.*, value.*});
            if(value.* != Limits.WALL) {
                return true;
            }
        }
        return false;
    }

};