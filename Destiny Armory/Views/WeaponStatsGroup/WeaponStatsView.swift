
import SwiftUI

struct WeaponStatsView: View {
    
    @Binding var stats: WeaponModel.Stats
    
    let defaultStats: WeaponModel.Stats
    
    let defaultMirror: Mirror
    
    //зеркало позволяет сделать из структуры массив
    let mirror: Mirror
    
    init(stats: Binding<WeaponModel.Stats>, defaultStats: WeaponModel.Stats) {
        _stats = Binding(projectedValue: stats)
        self.defaultStats = defaultStats
        self.mirror = Mirror(reflecting: stats.wrappedValue)
        self.defaultMirror = Mirror(reflecting: defaultStats)
    }
    
    let statsWithBar = ["accuracy", "impact", "blast_radius", "velocity", "stability", "range", "handling", "reload_speed", "swing_speed", "shield_duration", "guard_efficiency", "guard_resistance"]
    
    var body: some View {
        VStack{
            ForEach(Array(mirror.children), id: \.label) { child in
                
                let subMirror = Mirror(reflecting: child.value)
                
                let childDefaultValue = getDefaultValue(child: child, defaultMirror: defaultMirror)
                
                if subMirror.children.count != 0 && statsWithBar.contains(child.label!) {
                    HStack{
                        Text(child.label!.replacingOccurrences(of: "_", with: " "))
                        
                        Spacer()
                        
                        StatBar(statValue: child.value as! Int, defaultValue: childDefaultValue!)
                            .frame(maxWidth: CGFloat(UIScreen.main.bounds.width / 2), alignment: .leading)
                    }
                }
            }
            .font(Font.custom("Futura-Medium", fixedSize: 14))
            
            Divider()
            
            HStack{
                if stats.aim_assistance != nil && stats.aim_assistance != 0 {
                    Text("AA: \(stats.aim_assistance!)")
                        .foregroundColor(stats.aim_assistance == defaultStats.aim_assistance ? .white : .yellow)
                }
                if stats.zoom != nil && stats.zoom != 0{
                    Text("Zoom: \(stats.zoom!)")
                        .foregroundColor(stats.zoom == defaultStats.zoom ? .white : .yellow)
                }
                if stats.recoil_direction != nil && stats.recoil_direction != 0{
                    Text("Recoil: \(stats.recoil_direction!)")
                        .foregroundColor(stats.recoil_direction == defaultStats.recoil_direction ? .white : .yellow)
                }
                if stats.magazine != nil {
                    Text("Magazine: \(stats.magazine!)")
                        .foregroundColor(stats.magazine == defaultStats.magazine ? .white : .yellow)
                }
                if stats.rounds_per_minute != nil {
                    Text("RPM: \(stats.rounds_per_minute!)")
                        .foregroundColor(stats.rounds_per_minute == defaultStats.rounds_per_minute ? .white : .yellow)
                }
                if stats.ammo_capacity != nil {
                    Text("Ammo capacity: \(stats.ammo_capacity!)")
                        .foregroundColor(stats.ammo_capacity == defaultStats.ammo_capacity ? .white : .yellow)
                }
                if stats.charge_time != nil {
                    Text("Charge time: \(stats.charge_time!)")
                        .foregroundColor(stats.charge_time == defaultStats.charge_time ? .white : .yellow)
                }
                if stats.charge_rate != nil {
                    Text("Charge rate: \(stats.charge_rate!)")
                        .foregroundColor(stats.charge_rate == defaultStats.charge_rate ? .white : .yellow)
                }
                if stats.draw_time != nil {
                    Text("Draw time: \(stats.draw_time!)")
                        .foregroundColor(stats.draw_time == defaultStats.draw_time ? .white : .yellow)
                }
            }
            .font(Font.custom("Futura-Medium", fixedSize: 10))
        }
    }
}

func getDefaultValue(child: Mirror.Child, defaultMirror: Mirror) -> Int?{
    var returnValue: Int? = nil
    for i in Array(defaultMirror.children){
        if i.label == child.label{
            returnValue = i.value as? Int
        }
    }
    return returnValue
}

//struct WeaponStatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeaponStatsView(stats: previewWeapon.stats, defaultStats: previewWeapon.stats)
//    }
//}
