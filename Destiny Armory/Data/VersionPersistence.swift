import Foundation

class VersionPersistence{
    static let storage = VersionPersistence()
    
    private let versionKey = "versionKey"
    var version: String?{
        set {UserDefaults.standard.set(newValue, forKey: versionKey)}
        get {return UserDefaults.standard.string(forKey: versionKey)}
    }
}

