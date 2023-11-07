const std = @import("std");

pub fn generateSeed() u64 {
    var seed: u64 = undefined;
    std.os.getrandom(std.mem.asBytes(&seed)) catch {
        return 0;
    };
    return seed;
}