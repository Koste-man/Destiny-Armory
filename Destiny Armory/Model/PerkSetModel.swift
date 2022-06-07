import Foundation

class PerkSetModel{
    
    typealias PerkSets = [String: PerkSet]
    
    struct PerkSet: Codable{
        let hash: Int
        
        let reusablePlugItems: [ReusablePlugItem]?
    }
    
    struct ReusablePlugItem: Codable{
        let plugItemHash: Int
    }
    
}

