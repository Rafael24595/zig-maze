const std = @import("std");

const RandomUtils = @import("./RandomUtils.zig");
const Optional = @import("../Optional.zig").Optional;
const DefaultPrng = std.rand.DefaultPrng;

var instance = Optional(Random).none();

pub const Random = struct {

    const Self = @This();

    seed: u64,
    rnd: DefaultPrng,

    fn init(seed: u64) Random {
        return Random {
            .seed = seed,
            .rnd = DefaultPrng.init(seed)
        };
    }

    pub fn initialize(seed: u64) !Random {
        if(instance.isSome()) {
            return error.InvalidParam;
        }
        instance = Optional(Random).some(Random.init(seed));
        return instance.unwrap();
    }

    pub fn getInstance() !Random {
        if(instance.isNone()) {
            return error.InvalidParam;
        }
        return instance.unwrap();
    }

    pub fn integerRange(self: *Self, comptime T: type, min: T, max: T) T {
        return self.rnd.random().intRangeAtMost(u8, min, max);
    }

};