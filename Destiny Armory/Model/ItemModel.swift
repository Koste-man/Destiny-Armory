import Foundation

class ItemModel{
    
    typealias Items = [String: Item]
    
    struct Item: Codable{
        let displayProperties: DisplayProperties
        let iconWatermark: String?
        
        let hash: Int
        let screenshot: String?
        let itemTypeDisplayName: String?
        let flavorText: String?
        
        let tooltipStyle: String?
        
        let inventory: Inventory
        
        let perks: [Perk]?
        
        //perk stats
        let investmentStats: [InvestmentStats]?
        
        let equippingBlock: EquippingBlock?
        //3
        let itemType: Int
        let itemSubType: Int
        
        let defaultDamageType: Int?
        
        let stats: WeaponStats?
        
        let sockets: WeaponSocketsModel.Sockets?
        
        let quality: Quality?
        
        let itemCategoryHashes: [Int]?
        
        let traitIds: [String]?
    }
    
    struct Perk: Codable{
        let perkHash: Int
    }
    
    struct Inventory: Codable{
        let tierType: Int
    }
    
    struct InvestmentStats: Codable{
        let value: Int
        
        let statTypeHash: Int
    }
    
    struct DisplayProperties: Codable{
        let description: String
        let name: String
        let icon: String?
    }
    
    struct EquippingBlock: Codable{
        let ammoType: Int
    }
    
    ///
    struct Quality: Codable{
        let versions: [Version]
    }
    
    struct Version: Codable {
        let powerCapHash: Int
    }
    ///
    
    struct WeaponStats: Codable{
        let stats: ItemStats
    }
    
    class ItemStats: Codable{
        let impact: Impact?
        let accuracy: Accuracy?
        let blastRadius: BlastRadius?
        let velocity: Velocity?
        let range: Range?
        let stability: Stability?
        let handling: Handling?
        let reloadSpeed: ReloadSpeed?
        let swingSpeed: SwingSpeed?
        let shieldDuration: ShieldDuration?
        let guardEfficiency: GuardEfficiency?
        let guardResistance: GuardResistance?
        
        //numbers only stats
        let chargeTime: ChargeTime?
        let chargeRate: ChargeRate?
        let roundsPerMinute: RoundsPerMinute?
        let magazine: Magazine?
        let ammoCapacity: AmmoCapacity?
        let drawTime: DrawTime?
        
        //hidden stats
        let zoom: Zoom?
        let recoilDirection: RecoilDirection?
        let aimAssistance: AimAssistance?
        let inventorySize: InventorySize?
        
        enum CodingKeys: String, CodingKey {
            case impact = "4043523819"
            case accuracy = "1591432999"
            case blastRadius = "3614673599"
            case velocity = "2523465841"
            case range = "1240592695"
            case stability = "155624089"
            case handling = "943549884"
            case reloadSpeed = "4188031367"
            case swingSpeed = "2837207746"
            case shieldDuration = "1842278586"
            case guardEfficiency = "2762071195"
            case guardResistance = "209426660"
            
            //numbers only stats
            case chargeTime = "2961396640"
            case chargeRate = "3022301683"
            case roundsPerMinute = "4284893193"
            case magazine = "3871231066"
            case ammoCapacity = "925767036"
            case drawTime = "447667954"
            
            //hidden stats
            case zoom = "3555269338"
            case recoilDirection =  "2715839340"
            case aimAssistance = "1345609583"
            case inventorySize = "1931675084"
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.impact = try container.decodeIfPresent(Impact.self, forKey: .impact)
            self.accuracy = try container.decodeIfPresent(Accuracy.self, forKey: .accuracy)
            self.blastRadius = try container.decodeIfPresent(BlastRadius.self, forKey: .blastRadius)
            self.velocity = try container.decodeIfPresent(Velocity.self, forKey: .velocity)
            self.range = try container.decodeIfPresent(Range.self, forKey: .range)
            self.stability = try container.decodeIfPresent(Stability.self, forKey: .stability)
            self.handling = try container.decodeIfPresent(Handling.self, forKey: .handling)
            self.reloadSpeed = try container.decodeIfPresent(ReloadSpeed.self, forKey: .reloadSpeed)
            self.swingSpeed = try container.decodeIfPresent(SwingSpeed.self, forKey: .swingSpeed)
            self.shieldDuration = try container.decodeIfPresent(ShieldDuration.self, forKey: .shieldDuration)
            self.guardEfficiency = try container.decodeIfPresent(GuardEfficiency.self, forKey: .guardEfficiency)
            self.guardResistance = try container.decodeIfPresent(GuardResistance.self, forKey: .guardResistance)
            self.chargeTime = try container.decodeIfPresent(ChargeTime.self, forKey: .chargeTime)
            self.chargeRate = try container.decodeIfPresent(ChargeRate.self, forKey: .chargeRate)
            self.roundsPerMinute = try container.decodeIfPresent(RoundsPerMinute.self, forKey: .roundsPerMinute)
            self.magazine = try container.decodeIfPresent(Magazine.self, forKey: .magazine)
            self.ammoCapacity = try container.decodeIfPresent(AmmoCapacity.self, forKey: .ammoCapacity)
            self.drawTime = try container.decodeIfPresent(DrawTime.self, forKey: .drawTime)
            self.zoom = try container.decodeIfPresent(Zoom.self, forKey: .zoom)
            self.recoilDirection = try container.decodeIfPresent(RecoilDirection.self, forKey: .recoilDirection)
            self.aimAssistance = try container.decodeIfPresent(AimAssistance.self, forKey: .aimAssistance)
            self.inventorySize = try container.decodeIfPresent(InventorySize.self, forKey: .inventorySize)
        }
    }
    
    struct Impact: Codable{
        let statHash: Int
        var value: Int
    }
    struct Accuracy: Codable{
        let statHash: Int
        var value: Int
    }
    struct BlastRadius: Codable{
        let statHash: Int
        var value: Int
    }
    struct Velocity: Codable{
        let statHash: Int
        var value: Int
    }
    struct Range: Codable{
        let statHash: Int
        var value: Int
    }
    struct Stability: Codable{
        let statHash: Int
        var value: Int
    }
    struct Handling: Codable{
        let statHash: Int
        var value: Int
    }
    struct ReloadSpeed: Codable{
        let statHash: Int
        var value: Int
    }
    struct SwingSpeed: Codable{
        let statHash: Int
        var value: Int
    }
    struct ShieldDuration: Codable{
        let statHash: Int
        var value: Int
    }
    struct GuardEfficiency: Codable{
        var value: Int
        let statHash: Int
    }
    struct GuardResistance: Codable{
        var value: Int
        let statHash: Int
    }
    struct ChargeTime: Codable{
        var value: Int
        let statHash: Int
    }
    struct ChargeRate: Codable{
        var value: Int
        let statHash: Int
    }
    struct RoundsPerMinute: Codable{
        var value: Int
        let statHash: Int
    }
    struct Magazine: Codable{
        var value: Int
        let statHash: Int
    }
    struct AmmoCapacity: Codable{
        var value: Int
        let statHash: Int
    }
    struct DrawTime: Codable{
        var value: Int
        let statHash: Int
    }
    struct Zoom: Codable{
        var value: Int
        let statHash: Int
    }
    struct RecoilDirection: Codable{
        var value: Int
        let statHash: Int
    }
    struct AimAssistance: Codable{
        var value: Int
        let statHash: Int
    }
    struct InventorySize: Codable{
        var value: Int
        let statHash: Int
    }
    
    
}
