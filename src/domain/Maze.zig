const std = @import("std");
const Room = @import("./Room.zig").Room;

pub const Maze = struct {
    
    const Self = @This();

    panel: std.ArrayList(std.ArrayList(Room)),

    pub fn init(width: usize, height: usize) std.mem.Allocator.Error!Maze {
        return Maze{ .panel = try fill(width, height) };
    }

    fn fill(width: usize, height: usize) std.mem.Allocator.Error!std.ArrayList(std.ArrayList(Room)) {
        const allocator = std.heap.page_allocator;
        var panel = std.ArrayList(std.ArrayList(Room)).init(allocator);
        for (width, 0 .. width) |_, _| {
            var row = std.ArrayList(Room).init(allocator);
            try panel.append(row);
            for (height, 0 .. height) |_, _| {
                try row.append(try Room.init());
            }
        }
        return panel;
    }

};
