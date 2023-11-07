const RandomUtils = @import("../random/RandomUtils.zig");
const Optional = @import("../Optional.zig").Optional;

const std = @import("std");

var instance = Optional(Configuration).none();

pub const Configuration = struct {

    const Self = @This();

    seed: u64,

    fn init() Configuration {
        return Configuration {
            .seed = RandomUtils.generateSeed()
        };
    }

    pub fn initialize() !Configuration {
        if(instance.isSome()) {
            return error.InvalidParam; 
        }
        instance = Optional(Configuration).some(Configuration.init());
        return instance.unwrap();
    }

    pub fn getInstance() Configuration {
        if(instance.isNone()) {
            return error.InvalidParam;
        }
        return instance.unwrap();
    }

};