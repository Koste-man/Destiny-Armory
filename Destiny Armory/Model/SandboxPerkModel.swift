import Foundation

class SandboxPerkModel{
    typealias SandboxPerks = [String: SandboxPerk]

    struct SandboxPerk: Codable {
        let displayProperties: DisplayProperties?
        let isDisplayable: Bool
        let hash: Int
    }

    struct DisplayProperties: Codable {
        let icon: String?
        let description: String?
        let name: String?
    }
}


