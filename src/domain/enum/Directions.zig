const std = @import("std");
const DefaultPrng = std.rand.DefaultPrng;

pub const Directions = enum {
    NORTH,
    SOUTH,
    EAST,
    WEST,

    pub fn asCollection() std.mem.Allocator.Error![]Directions {
        const allocator = std.heap.page_allocator;
        var collection = std.ArrayList(Directions).init(allocator);
        inline for (@typeInfo(Directions).Enum.fields) |f| {
            var direction: Directions = @enumFromInt(f.value);
            try collection.append(direction);
        }
        return collection.items;
    }

    pub fn asCollectionWithExceptions(exceptions: []Directions) std.mem.Allocator.Error![]Directions {
        const allocator = std.heap.page_allocator;
        var collection = std.ArrayList(Directions).init(allocator);
        inline for (@typeInfo(Directions).Enum.fields) |f| {
            var direction: Directions = @enumFromInt(f.value);
            if(!includes(exceptions, direction)) {
                try collection.append(direction);
            }
        }
        return collection.items;
    }

    pub fn randomWithExceptions(exceptions: []Directions) std.mem.Allocator.Error!Directions {
        const directions = try asCollectionWithExceptions(exceptions);
        _ = directions;
    }

    fn includes(exceptions: []Directions, direction: Directions) bool {
        for (exceptions) |value| {
            if(value == direction) {
                return true;
            }
        }
        return false;
    }

};