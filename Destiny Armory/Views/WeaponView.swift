import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

struct WeaponView: View {
    
    var weapon: WeaponModel.Weapon
    
    @State var stats: WeaponModel.Stats
    
    let defaultStats: WeaponModel.Stats
    
    init(weapon: WeaponModel.Weapon, viewModel: JSONModel){
        self.weapon = weapon
        _stats = State(initialValue: weapon.stats)
        self.defaultStats = weapon.stats
        
        self.weapon.perks = viewModel.getWeaponPerks(weapon: weapon, perks: viewModel.perks)
        self.weapon.catalyst = viewModel.getWeaponCatalyst(weapon: weapon, perks: viewModel.perks)
        
        if self.weapon.catalyst != nil{
            _stats = State(wrappedValue: PerkCalculationModel.shared.calculateCatalystStats(stats: self.weapon.stats, plusStats: (self.weapon.catalyst?.stats)!))
        }
    }
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, alignment: .center)
                .ignoresSafeArea()
            
            ScrollView{
                VStack{
                    WeaponViewImage(weapon: weapon)
                    
                    Text(weapon.flavorText)
                        .multilineTextAlignment(.center)
                        .background(Color.gray.opacity(0.2)).cornerRadius(10)
                        .padding([.leading, .trailing], 2)
                    
                    WeaponStatsView(stats: $stats, defaultStats: defaultStats)
                        .background(Color.gray.opacity(0.2)).cornerRadius(10)
                    
                    WeaponPerksView(weapon: weapon, stats: $stats)
                }
                .foregroundColor(Color.white)
            }
            .font(Font.custom("Futura-Medium", fixedSize: 15))
        }
        .navigationTitle(weapon.name)
    }
}

//struct WeaponView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeaponView(weapon: previewWeapon, viewModel: JSONModel())
//    }
//}
