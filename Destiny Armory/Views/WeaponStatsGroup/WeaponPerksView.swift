
import SwiftUI

struct WeaponPerksView: View {
    
    let weapon: WeaponModel.Weapon
    
    @State var lastColumn1Perk: WeaponModel.Perk?
    @State var lastColumn2Perk: WeaponModel.Perk?
    @State var lastColumn3Perk: WeaponModel.Perk?
    @State var lastColumn4Perk: WeaponModel.Perk?
    
    @State var perkDescription = ""
    @State var perkImage = ""
    
    @Binding var stats: WeaponModel.Stats
    
    @State var rowsBackground:[[Bool]] = []
    
    init(weapon: WeaponModel.Weapon, stats: Binding<WeaponModel.Stats>){
        self.weapon = weapon
        _stats = Binding(projectedValue: stats)
        
        var rB: [[Bool]] = []
        for index in 0 ..< weapon.perks!.count{
            rB.append([])
            for _ in weapon.perks![index]{
                rB[index].append(false)
            }
        }
        _rowsBackground = State(initialValue: rB)
    }
    
    var body: some View {
        HStack(alignment: .top){
            ForEach(Array(weapon.perks!.enumerated()), id: \.1.description) {(firstIndex, perks) in
                VStack{
                    ForEach(Array(perks.enumerated()), id: \.1.hash) {(secondIndex, perk) in
                        createButton(perk: perk, firstIndex: firstIndex, secondIndex: secondIndex)
                    }
                }
            }
            
            if weapon.catalyst?.perks != nil {
                VStack{
                    ForEach(Array((weapon.catalyst?.perks)!), id: \.hash) { perk in
                        Button {
                            perkImage = perk.icon
                            perkDescription = (perk.name + ": " + perk.description)
                        } label: {
                            IconImage(icon: perk.icon)
                        }
                        .background(Color.yellow.opacity(0.5))
                        .cornerRadius(10)
                        .padding(.leading, 8)
                    }
                }
            }
        }
        
        HStack(alignment: .top){
            IconImage(icon: perkImage)
            
            Text(perkDescription)
        }
    }
    
    private func createButton(perk: WeaponModel.Perk, firstIndex: Int, secondIndex: Int) -> some View{
        Button {
            if firstIndex == 1{
                stats = PerkCalculationModel.shared.calculateStatsForRow(lastColumnPerk: lastColumn1Perk, stats: stats, perk: perk, weapon: weapon)
                lastColumn1Perk = perk
            }else if firstIndex == 2{
                stats = PerkCalculationModel.shared.calculateStatsForRow(lastColumnPerk: lastColumn2Perk, stats: stats, perk: perk, weapon: weapon)
                lastColumn2Perk = perk
            }else if firstIndex == 3{
                stats = PerkCalculationModel.shared.calculateStatsForRow(lastColumnPerk: lastColumn3Perk, stats: stats, perk: perk, weapon: weapon)
                lastColumn3Perk = perk
            }else if firstIndex == 4{
                stats = PerkCalculationModel.shared.calculateStatsForRow(lastColumnPerk: lastColumn4Perk, stats: stats, perk: perk, weapon: weapon)
                lastColumn4Perk = perk
            }
            
            if rowsBackground[firstIndex].count > 1{
                rowFalse(firstIndex: firstIndex)
                rowsBackground[firstIndex][secondIndex] = true
            }
            
            perkImage = perk.icon
            perkDescription = (perk.name + ": " + perk.description)
        } label: {
            IconImage(icon: perk.icon)
        }
        .background(rowsBackground[firstIndex][secondIndex] ? Color.blue.opacity(0.7) : Color.black.opacity(0.8))
        .cornerRadius(10)
    }
    
    private func rowFalse(firstIndex: Int){
        for i in rowsBackground[firstIndex].indices{
            rowsBackground[firstIndex][i] = false
        }
    }
}

//struct WeaponPerksView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeaponStatsFramePerks(weapon: previewWeapon)
//    }
//}
