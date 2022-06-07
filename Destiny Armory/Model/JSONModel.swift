import SwiftUI

class JSONModel: ObservableObject {
    
    @Published var isLoading = [false, false]
    
    @Published var weapons: [WeaponModel.Weapon] = []
    
    var manifestVersion = VersionPersistence.storage.version
    
    var perkSets: [PerkSetModel.PerkSet] = []
    
    var perks: [ItemModel.Item] = []
    
    var sandboxPerks: [SandboxPerkModel.SandboxPerk] = []
    
    var inventoryURL = ""
    
    var perkSetsURL = ""
    
    var sandboxPerksURL = ""
    
    func initialFetchFromBungie(){
        guard self.weapons.isEmpty, self.perkSets.isEmpty else {return}
        
        if CoreDataController.shared.isEmpty(){
            fetchJSONInventoryItems()
        }else{
            fetchCoreDataInventoryItems()
        }
        
        fetchJSONPerkSets()
        fetchSandboxPerks()
    }
    
    func updateFetchFromBungie(){
        DispatchQueue.main.async {
            self.weapons.removeAll()
            self.perks.removeAll()
            self.perkSets.removeAll()
            self.sandboxPerks.removeAll()
        }
        
        fetchJSONInventoryItems()
        fetchJSONPerkSets()
        fetchSandboxPerks()
    }
    
    func updateURLfromManifest(onCompletion: @escaping (Bool) -> Void){
        guard let url = URL(string: "https://www.bungie.net/Platform/Destiny2/Manifest/") else {return}
        var request = URLRequest(url: url)
        request.addValue("f67cabcc7cb14092bcfffffcdc1c3397", forHTTPHeaderField: "X-API-Key")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {return}
            
            do{
                let JSONManifest = try JSONDecoder().decode(BungieManifestModel.Manifest.self, from: data)
                
                VersionPersistence.storage.version = JSONManifest.response.version
                
                self?.inventoryURL = JSONManifest.response.jsonWorldComponentContentPaths.en.DestinyInventoryItemDefinition
                
                self?.perkSetsURL = JSONManifest.response.jsonWorldComponentContentPaths.en.DestinyPlugSetDefinition
                
                self?.sandboxPerksURL = JSONManifest.response.jsonWorldComponentContentPaths.en.DestinySandboxPerkDefinition
                
                onCompletion(true)
                
            }catch{
                print("JSON Manifest decode error \(error)")
            }
        }
        task.resume()
        
    }
    
    private func fetchCoreDataInventoryItems(){
        let data = CoreDataController.shared.getInventoryItems()!
        
        do{
            let JSONInventoryItems = try JSONDecoder().decode(ItemModel.Items.self, from: data)
            
            DispatchQueue.main.async {
                self.perks = self.getJSONPerks(JSONInventoryItems: JSONInventoryItems)
                self.weapons = self.getJSONWeapons(JSONInventoryItems: JSONInventoryItems)
                self.isLoading[0] = false
            }
            
        }catch{
            print("Core Data Inventory Items decode error \(error)")
        }
        
    }
    
    private func fetchJSONInventoryItems(){
        guard let url = URL(string: "https://www.bungie.net" + inventoryURL) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {return}
            
            CoreDataController.shared.save(JSONData: data)
            
            do{
                let JSONInventoryItems = try JSONDecoder().decode(ItemModel.Items.self, from: data)
                
                DispatchQueue.main.async {
                    self?.perks = self!.getJSONPerks(JSONInventoryItems: JSONInventoryItems)
                    self?.weapons = self!.getJSONWeapons(JSONInventoryItems: JSONInventoryItems)
                    self?.isLoading[0] = false
                }
                
            }catch{
                print("JSON Inventory Items decode error \(error)")
            }
        }
        task.resume()
    }
    
    private func fetchJSONPerkSets(){
        
        guard let url = URL(string: "https://www.bungie.net" + perkSetsURL) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {return}
            
            do{
                let JSONPerkSets = try JSONDecoder().decode(PerkSetModel.PerkSets.self, from: data)
                
                DispatchQueue.main.async {
                    for i in JSONPerkSets{
                        if i.value.reusablePlugItems != nil{
                            self?.perkSets.append(PerkSetModel.PerkSet(hash: i.value.hash, reusablePlugItems: i.value.reusablePlugItems))
                        }
                    }
                    self?.isLoading[1] = false
                }
            }catch{
                print("JSON Perk Sets decode error \(error)")
            }
        }
        task.resume()
    }
    
    private func fetchSandboxPerks(){
        guard let url = URL(string: "https://www.bungie.net" + sandboxPerksURL) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {return}
            
            do{
                let JSONSandboxPerks = try JSONDecoder().decode(SandboxPerkModel.SandboxPerks.self, from: data)
                
                DispatchQueue.main.async {
                    for i in JSONSandboxPerks{
                        if i.value.displayProperties?.name != nil{
                            self?.sandboxPerks.append(i.value)
                        }
                    }
                }
            }catch{
                print("JSON Sandbox Perks decode error \(error)")
            }
        }
        task.resume()
    }
    
    private func getJSONPerks(JSONInventoryItems: ItemModel.Items) -> [ItemModel.Item]{
        var perks: [ItemModel.Item] = []
        
        for item in JSONInventoryItems{
            // 610365472 <ItemCategory "Weapon Mods">
            if item.value.itemCategoryHashes?.contains(610365472) == true || item.value.traitIds?.contains("item_type.exotic_catalyst") == true {
                perks.append(item.value)
            }
        }
        return perks
    }
    
    private func getJSONWeapons(JSONInventoryItems: ItemModel.Items) -> [WeaponModel.Weapon]{
        var weapons: [WeaponModel.Weapon] = []
        
        for i in JSONInventoryItems{
            // 3 DestinyItemType "Weapon"
            if i.value.itemType == 3 && sunsetSort(item: i.value){
                weapons.append(WeaponModel.Weapon(hash: i.value.hash,
                                                  name: i.value.displayProperties.name,
                                                  icon: i.value.displayProperties.icon!,
                                                  iconWatermark: i.value.iconWatermark,
                                                  screenshot: i.value.screenshot!,
                                                  flavorText: i.value.flavorText!,
                                                  tier: i.value.inventory.tierType,
                                                  elementClass: i.value.defaultDamageType!,
                                                  weaponType: i.value.itemTypeDisplayName!,
                                                  stats: getWeaponStats(weapon: i.value),
                                                  sockets: i.value.sockets!,
                                                  perks: nil))
            }
        }
        return weapons
    }
    
    private func getWeaponStats(weapon: ItemModel.Item) -> WeaponModel.Stats{
        return WeaponModel.Stats(impact: weapon.stats?.stats.impact?.value,
                                 accuracy: weapon.stats?.stats.accuracy?.value,
                                 blast_radius: weapon.stats?.stats.blastRadius?.value,
                                 velocity: weapon.stats?.stats.velocity?.value,
                                 range: weapon.stats?.stats.range?.value,
                                 stability: weapon.stats?.stats.stability?.value,
                                 handling: weapon.stats?.stats.handling?.value,
                                 reload_speed: weapon.stats?.stats.reloadSpeed?.value,
                                 swing_speed: weapon.stats?.stats.swingSpeed?.value,
                                 shield_duration: weapon.stats?.stats.shieldDuration?.value,
                                 guard_efficiency: weapon.stats?.stats.guardEfficiency?.value,
                                 guard_resistance: weapon.stats?.stats.guardResistance?.value,
                                 charge_time: weapon.stats?.stats.chargeTime?.value,
                                 charge_rate: weapon.stats?.stats.chargeRate?.value,
                                 rounds_per_minute: weapon.stats?.stats.roundsPerMinute?.value,
                                 magazine: weapon.stats?.stats.magazine?.value,
                                 ammo_capacity: weapon.stats?.stats.ammoCapacity?.value,
                                 draw_time: weapon.stats?.stats.drawTime?.value,
                                 zoom: weapon.stats?.stats.zoom?.value,
                                 recoil_direction: weapon.stats?.stats.recoilDirection?.value,
                                 aim_assistance: weapon.stats?.stats.aimAssistance?.value,
                                 inventory_size: weapon.stats?.stats.inventorySize?.value)
    }
    
    func getWeaponCatalyst(weapon: WeaponModel.Weapon, perks: [ItemModel.Item]) -> WeaponModel.Catalyst?{
        guard weapon.tier == 6 else {return nil}
        // "Wavesplitter Catalyst".droplast(9) == Wavesplitter
        if let catalystIndex = perks.firstIndex(where: {weapon.name.contains($0.displayProperties.name.dropLast(9)) && ($0.traitIds != nil && $0.traitIds!.contains("item_type.exotic_catalyst"))}) {
            //            print("search catalyst by name")
            return WeaponModel.Catalyst(stats: getPerkStats(item: perks[catalystIndex]),
                                        hash: perks[catalystIndex].hash,
                                        perks: getCatalystPerks(catalyst: perks[catalystIndex]))
        } else {
            //            print("search catalyst by plug sources")
            for entry in weapon.sockets.socketEntries{
                if entry.plugSources == 3 && weapon.tier == 6{
                    let catalystIndex = perks.firstIndex(where: {$0.hash == entry.reusablePlugItems?.last?.plugItemHash})!
                    
                    return WeaponModel.Catalyst(stats: getPerkStats(item: perks[catalystIndex]),
                                                hash: perks[catalystIndex].hash,
                                                perks: getCatalystPerks(catalyst: perks[catalystIndex]))
                }
            }
        }
        return nil
    }
    
    private func getCatalystPerks(catalyst: ItemModel.Item) -> [WeaponModel.Perk]?{
        var returnPerks: [WeaponModel.Perk] = []
        for catalystPerk in catalyst.perks!{
            for perk in sandboxPerks{
                if catalystPerk.perkHash == perk.hash{
                    returnPerks.append(WeaponModel.Perk(name: perk.displayProperties?.name ?? "error",
                                                        hash: perk.hash,
                                                        icon: perk.displayProperties?.icon ?? "error",
                                                        description: perk.displayProperties?.description ?? "error",
                                                        stats: WeaponModel.Stats()))
                }
            }
        }
        
        return returnPerks
    }
    
    func getWeaponPerks(weapon: WeaponModel.Weapon, perks: [ItemModel.Item]) -> [[WeaponModel.Perk]]{
        var returnValue: [[WeaponModel.Perk]] = []
        
        for entry in weapon.sockets.socketEntries{
            // plugSources 2 - random perks 6 - reusable (non random) perks 0 - just for osteo striga
            if (entry.plugSources == 2 || entry.plugSources == 6 || (entry.plugSources == 0 && entry.socketTypeHash != 624645373)){
                if entry.randomizedPlugSetHash != nil{
                    returnValue.append(findPerksInPerkSets(perksHash: entry.randomizedPlugSetHash!))
                }else{
                    returnValue.append(findPerksInPerkSets(perksHash: entry.reusablePlugSetHash!))
                }
            }
        }
        return returnValue
    }
    
    private func findPerksInPerkSets(perksHash: Int) -> [WeaponModel.Perk]{
        var returnPerks: [WeaponModel.Perk] = []
        var duplicateProtection: [Int] = []
        
        let perkSetsIndex = perkSets.firstIndex(where: {$0.hash == perksHash})!
        
        for i in perkSets[perkSetsIndex].reusablePlugItems!{
            for perk in perks {
                if perk.hash == i.plugItemHash && !duplicateProtection.contains(perk.hash){
                    duplicateProtection.append(perk.hash)
                    
                    returnPerks.append( WeaponModel.Perk(name: perk.displayProperties.name,
                                                         hash: perk.hash,
                                                         icon: perk.displayProperties.icon!,
                                                         description: perk.displayProperties.description,
                                                         stats: getPerkStats(item: perk)))
                }
            }
        }
        return returnPerks
    }
    
    private func sunsetSort(item: ItemModel.Item) -> Bool{
        if item.quality?.versions.count == 1 && item.quality?.versions[0].powerCapHash == 2759499571{
            return true
        }else if item.quality?.versions.count == 2 && item.quality?.versions[1].powerCapHash == 2759499571{
            return true
        }else if item.quality?.versions.count == 3 && item.quality?.versions[2].powerCapHash == 2759499571{
            return true
        }else {
            return false
        }
    }
    
    func getPerkStats(item: ItemModel.Item) -> WeaponModel.Stats{
        var returnStats = WeaponModel.Stats()
        
        for stat in item.investmentStats!{
            switch stat.statTypeHash {
            case 4043523819: returnStats.impact = stat.value
            case 1591432999: returnStats.accuracy = stat.value
            case 3614673599: returnStats.blast_radius = stat.value
            case 2523465841: returnStats.velocity = stat.value
            case 1240592695: returnStats.range = stat.value
            case 155624089: returnStats.stability = stat.value
            case 943549884: returnStats.handling = stat.value
            case 4188031367: returnStats.reload_speed = stat.value
            case 2837207746: returnStats.swing_speed = stat.value
            case 1842278586: returnStats.shield_duration = stat.value
            case 2762071195: returnStats.guard_efficiency = stat.value
            case 209426660: returnStats.guard_resistance = stat.value
            case 2961396640: returnStats.charge_time = stat.value
            case 3022301683: returnStats.charge_rate = stat.value
            case 4284893193: returnStats.rounds_per_minute = stat.value
            case 3871231066: returnStats.magazine = stat.value
            case 925767036: returnStats.ammo_capacity = stat.value
            case 447667954: returnStats.draw_time = stat.value
            case 3555269338: returnStats.zoom = stat.value
            case 2715839340: returnStats.recoil_direction = stat.value
            case 1345609583: returnStats.aim_assistance = stat.value
            case 1931675084: returnStats.inventory_size = stat.value
                
            default:
                break
            }
        }
        return returnStats
    }
}


