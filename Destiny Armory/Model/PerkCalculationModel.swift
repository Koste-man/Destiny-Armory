import Foundation

class PerkCalculationModel{
    static let shared = PerkCalculationModel()
    
    func getDefaultValue(child: Mirror.Child, defaultMirror: Mirror) -> Int?{
        var returnValue: Int? = nil
        for i in Array(defaultMirror.children){
            if i.label == child.label{
                returnValue = i.value as? Int
            }
        }
        return returnValue
    }
    
    func calculateCatalystStats(stats: WeaponModel.Stats, plusStats: WeaponModel.Stats) -> WeaponModel.Stats{
        return plusPerkStats(returnStats: stats, plusStats: plusStats)
    }
    
    func calculateStatsForRow(lastColumnPerk: WeaponModel.Perk? , stats: WeaponModel.Stats , perk: WeaponModel.Perk, weapon: WeaponModel.Weapon) -> WeaponModel.Stats{
        var returnStats = stats
        if weapon.perks != nil{
            if weapon.perks![1].count > 1 || weapon.perks![2].count > 1{
                if lastColumnPerk != nil{
                    returnStats = minusPerkStats(returnStats: returnStats, lastColumnPerk: lastColumnPerk!)
                }
                returnStats = plusPerkStats(returnStats: returnStats, plusStats: perk.stats)
            }
        }
        return returnStats
    }
    
    private func plusPerkStats(returnStats: WeaponModel.Stats, plusStats: WeaponModel.Stats) -> WeaponModel.Stats{
        var returnStats = returnStats
        
        if returnStats.aim_assistance != nil && plusStats.aim_assistance != nil {
            returnStats.aim_assistance! += plusStats.aim_assistance!
        }
        if returnStats.reload_speed != nil && plusStats.reload_speed != nil {
            returnStats.reload_speed! += plusStats.reload_speed!
        }
        if returnStats.magazine != nil && plusStats.magazine != nil {
            returnStats.magazine! += plusStats.magazine!
        }
        if returnStats.accuracy != nil && plusStats.accuracy != nil {
            returnStats.accuracy! += plusStats.accuracy!
        }
        if returnStats.draw_time != nil && plusStats.draw_time != nil {
            returnStats.draw_time! -= plusStats.draw_time!
        }
        if returnStats.range != nil && plusStats.range != nil {
            returnStats.range! += plusStats.range!
        }
        if returnStats.stability != nil && plusStats.stability != nil {
            returnStats.stability! += plusStats.stability!
        }
        if returnStats.impact != nil && plusStats.impact != nil {
            returnStats.impact! += plusStats.impact!
        }
        if returnStats.blast_radius != nil && plusStats.blast_radius != nil {
            returnStats.blast_radius! += plusStats.blast_radius!
        }
        if returnStats.velocity != nil && plusStats.velocity != nil {
            returnStats.velocity! += plusStats.velocity!
        }
        if returnStats.shield_duration != nil && plusStats.shield_duration != nil {
            returnStats.shield_duration! += plusStats.shield_duration!
        }
        if returnStats.guard_efficiency != nil && plusStats.guard_efficiency != nil {
            returnStats.guard_efficiency! += plusStats.guard_efficiency!
        }
        if returnStats.guard_resistance != nil && plusStats.guard_resistance != nil {
            returnStats.guard_resistance! += plusStats.guard_resistance!
        }
        if returnStats.charge_time != nil && plusStats.charge_time != nil {
            returnStats.charge_time! += plusStats.charge_time!
        }
        if returnStats.charge_rate != nil && plusStats.charge_rate != nil {
            returnStats.charge_rate! += plusStats.charge_rate!
        }
        if returnStats.ammo_capacity != nil && plusStats.ammo_capacity != nil {
            returnStats.ammo_capacity! += plusStats.ammo_capacity!
        }
        if returnStats.recoil_direction != nil && plusStats.recoil_direction != nil {
            returnStats.recoil_direction! += plusStats.recoil_direction!
        }
        if returnStats.handling != nil && plusStats.handling != nil {
            returnStats.handling! += plusStats.handling!
        }
        
        return returnStats
    }
    
    private func minusPerkStats(returnStats: WeaponModel.Stats, lastColumnPerk: WeaponModel.Perk) -> WeaponModel.Stats{
        var returnStats = returnStats
        
        if returnStats.aim_assistance != nil && lastColumnPerk.stats.aim_assistance != nil {
            returnStats.aim_assistance! -= lastColumnPerk.stats.aim_assistance!
        }
        if returnStats.reload_speed != nil && lastColumnPerk.stats.reload_speed != nil {
            returnStats.reload_speed! -= lastColumnPerk.stats.reload_speed!
        }
        if returnStats.magazine != nil && lastColumnPerk.stats.magazine != nil{
            returnStats.magazine! -= lastColumnPerk.stats.magazine!
        }
        if returnStats.accuracy != nil && lastColumnPerk.stats.accuracy != nil {
            returnStats.accuracy! -= lastColumnPerk.stats.accuracy!
        }
        if returnStats.draw_time != nil && lastColumnPerk.stats.draw_time != nil {
            returnStats.draw_time! += lastColumnPerk.stats.draw_time!
        }
        if returnStats.range != nil && lastColumnPerk.stats.range != nil{
            returnStats.range! -= lastColumnPerk.stats.range!
        }
        if returnStats.stability != nil && lastColumnPerk.stats.stability != nil{
            returnStats.stability! -= lastColumnPerk.stats.stability!
        }
        if returnStats.impact != nil && lastColumnPerk.stats.impact != nil {
            returnStats.impact! -= lastColumnPerk.stats.impact!
        }
        if returnStats.blast_radius != nil && lastColumnPerk.stats.blast_radius != nil {
            returnStats.blast_radius! -= lastColumnPerk.stats.blast_radius!
        }
        if returnStats.velocity != nil && lastColumnPerk.stats.velocity != nil {
            returnStats.velocity! -= lastColumnPerk.stats.velocity!
        }
        if returnStats.shield_duration != nil && lastColumnPerk.stats.shield_duration != nil {
            returnStats.shield_duration! -= lastColumnPerk.stats.shield_duration!
        }
        if returnStats.guard_efficiency != nil && lastColumnPerk.stats.guard_efficiency != nil {
            returnStats.guard_efficiency! -= lastColumnPerk.stats.guard_efficiency!
        }
        if returnStats.guard_resistance != nil && lastColumnPerk.stats.guard_resistance != nil {
            returnStats.guard_resistance! -= lastColumnPerk.stats.guard_resistance!
        }
        if returnStats.charge_time != nil && lastColumnPerk.stats.charge_time != nil {
            returnStats.charge_time! -= lastColumnPerk.stats.charge_time!
        }
        if returnStats.charge_rate != nil && lastColumnPerk.stats.charge_rate != nil {
            returnStats.charge_rate! -= lastColumnPerk.stats.charge_rate!
        }
        if returnStats.ammo_capacity != nil && lastColumnPerk.stats.ammo_capacity != nil {
            returnStats.ammo_capacity! -= lastColumnPerk.stats.ammo_capacity!
        }
        if returnStats.recoil_direction != nil && lastColumnPerk.stats.recoil_direction != nil {
            returnStats.recoil_direction! -= lastColumnPerk.stats.recoil_direction!
        }
        if returnStats.handling != nil && lastColumnPerk.stats.handling != nil {
            returnStats.handling! -= lastColumnPerk.stats.handling!
        }
        
        return returnStats
    }
}



