pub fn Optional(comptime T: type) type {
	return struct {

        const Self = @This();

        element: ?T,

        fn init(element: anytype) Self {
            return .{
                .element = element
            };
        }

        pub fn none() Self{
            return Self.init(null);
        }

        pub fn some(element: anytype) Self {
            return Self.init(element);
        }

        pub fn isSome(self: Self) bool {
            return self.element != null;
        }

        pub fn isNone(self: Self) bool {
            return !self.isSome();
        }

        pub fn unwrap(self: Self) !T {
            return self.element orelse error.InvalidParam;
        }
    };
}