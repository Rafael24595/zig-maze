const std = @import("std");

pub const Directions = enum {
    NORTH,
    SOUTH,
    EAST,
    WEST,

    pub fn asCollection() std.mem.Allocator.Error![]Directions {
        const allocator = std.heap.page_allocator;
        var collection = std.ArrayList(Directions).init(allocator);
        inline for (@typeInfo(Directions).Enum.fields) |f| {
            var direction: Directions = @enumFromInt( f.value) ;
            try collection.append(direction);
        }
        return collection.items;
    }

};