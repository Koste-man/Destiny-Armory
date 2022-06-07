import Foundation

class BungieManifestModel{
    struct Manifest: Codable{
        let response: Response
        
        enum CodingKeys: String, CodingKey {
            case response = "Response"
        }
    }

    struct Response: Codable{
        let version: String
        
        let jsonWorldComponentContentPaths: JsonWorldComponentContentPaths
    }

    struct JsonWorldComponentContentPaths: Codable{
        let en: En
    }

    struct En: Codable{
        let DestinyInventoryItemDefinition: String
        
        let DestinyPlugSetDefinition: String
        
        let DestinySandboxPerkDefinition: String
    }

}

