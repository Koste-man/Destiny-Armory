
import SwiftUI

@main
struct Destiny_ArmoryApp: App {
    
    var body: some Scene {
        WindowGroup {
            WeaponListView()
        }
    }
}


let previewWeapon = WeaponModel.Weapon(hash: 3973202132,
                                       name: "Thorn",
                                       icon: "/common/destiny2_content/icons/ba392591a98adb436d5f34db5af635c1.jpg",
                                       iconWatermark: nil,
                                       screenshot: "/common/destiny2_content/screenshots/3973202132.jpg",
                                       flavorText: "123",
                                       tier: 6,
                                       elementClass: 1,
                                       weaponType: "Test Cannon",
                                       stats: WeaponModel.Stats(impact: 25,
                                                                rounds_per_minute: 12,
                                                                magazine: 12),
                                       sockets: WeaponSocketsModel.Sockets(socketEntries: [WeaponSocketsModel.SocketEntrie(socketTypeHash: 12,
                                                                                                                           singleInitialItemHash: 12,
                                                                                                                           plugSources: 12,
                                                                                                                           randomizedPlugSetHash: nil,
                                                                                                                           reusablePlugSetHash: 813,
                                                                                                                           reusablePlugItems: nil)]),
                                       perks: [[WeaponModel.Perk(name: "test perk",
                                                                 hash: 2921090754,
                                                                 icon: "/common/destiny2_content/icons/e994975f4fae7a9a4e0d27e5173dece3.png",
                                                                 description: "gkhadsgiusoHGDSA",
                                                                 stats: WeaponModel.Stats(impact: 1))]])
