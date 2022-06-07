import Foundation

class WeaponModel{
    
    struct Weapon {
        let hash: Int
        let name: String
        let icon: String
        let iconWatermark: String?
        let screenshot: String
        let flavorText: String
        
        // 5 - legendary 6 - exotic
        let tier: Int
        //    let ammo_type: String
        let elementClass: Int
        let weaponType: String
        //    let powercap: Int?
        
        var catalyst: Catalyst?
        
        var stats: Stats
        
        let sockets: WeaponSocketsModel.Sockets
        
        var perks: [[Perk]]?
    }
    
    struct Catalyst{
        let stats: Stats?
        let hash: Int
        let perks: [Perk]?
    }
    
    struct Perk{
        let name: String
        let hash: Int
        let icon: String
        let description: String
        
        let stats: Stats
    }
    
    struct Stats{
        var impact: Int?
        var accuracy: Int?
        var blast_radius: Int?
        var velocity: Int?
        var range: Int?
        var stability: Int?
        var handling: Int?
        var reload_speed: Int?
        var swing_speed: Int?
        var shield_duration: Int?
        var guard_efficiency: Int?
        var guard_resistance: Int?
        
        //numbers only stats
        var charge_time: Int?
        var charge_rate: Int?
        var rounds_per_minute: Int?
        var magazine: Int?
        var ammo_capacity: Int?
        var draw_time: Int?
        
        //hidden stats
        var zoom: Int?
        var recoil_direction: Int?
        var aim_assistance: Int?
        var inventory_size: Int?
    }
}

class WeaponSocketsModel{
    struct Sockets: Codable{
        let socketEntries: [SocketEntrie]
    }
    
    struct SocketEntrie: Codable{
        let socketTypeHash: Int
        
        let singleInitialItemHash: Int
        // 2 or 6
        let plugSources: Int
        
        let randomizedPlugSetHash: Int?
        
        let reusablePlugSetHash: Int?
        
        let reusablePlugItems: [PlugItem]?
    }
    
    struct PlugItem: Codable{
        let plugItemHash: Int
    }
}


