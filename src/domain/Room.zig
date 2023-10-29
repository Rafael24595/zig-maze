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
	    const allocator = std.heap.page_allocator;
        var map: std.AutoHashMap(Directions, Limits) = std.AutoHashMap(Directions, Limits).init(allocator);
        for (try Directions.asCollection()) |direction| {
            try map.put(direction, Limits.WALL);    
        }
        return map;
    }

    pub fn rebuildWall(self: *Self, wall: Directions, structure: Limits) std.mem.Allocator.Error!void {
        return self.map.put(wall, structure);
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