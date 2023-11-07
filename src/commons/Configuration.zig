const Utils = @import("../domain/Utils.zig");

var instance: Configurarion = null;

pub const Configurarion = struct {

    const Self = @This();


    seed: u64,

    fn init() Configurarion {
        return Configurarion {
            .seed = Utils.generateSeed()
        };
    }

    pub fn getInstance() Configurarion {
        if(instance == null){
            instance = Configurarion.init();
        }
        return instance;
    }

};