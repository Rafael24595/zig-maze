const std = @import("std");

const Configuration = @import("./Configuration.zig").Configuration;
const Random = @import("../random/Random.zig").Random;

pub const Configurator = struct {

    pub fn configure() !Configuration {
        var args = try getArgs();
        var configuration = try Configuration.initialize();
        if(args.get("ENV_SEED")) | seed | {
            const integer = try std.fmt.parseInt(u64, seed, 10);
            configuration.seed = integer;
        }

        std.debug.print("Seed value: {} \n", .{configuration.seed});

        _ = try Random.initialize(configuration.seed);
        return configuration;
    }

    fn getArgs() std.mem.Allocator.Error!std.StringHashMap([] const u8) {
        const allocator = std.heap.page_allocator;
        var envs = std.StringHashMap([] const u8).init(allocator);
        try envs.put("ENV_SEED", "0");
        return envs;
    }

};