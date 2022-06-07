import Foundation
import CoreData

class CoreDataController: ObservableObject {
    
    static let shared = CoreDataController()
    
    let container = NSPersistentContainer(name: "CoreDataModel")
    
    let context: NSManagedObjectContext
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        
        context = container.viewContext
    }
    
    func save(JSONData: Data){
        if !isEmpty() {
            context.delete(try! context.fetch(JSONItemData.fetchRequest())[0])
        }
        
        let data = JSONItemData(context: context)
        data.data = JSONData
        
        try? context.save()
    }
    
    func getInventoryItems() -> Data?{
        return try! context.fetch(JSONItemData.fetchRequest())[0].data
    }
    
    func isEmpty() -> Bool{
        if try! context.fetch(JSONItemData.fetchRequest()).isEmpty {
            return true
        }else{
            return false
        }
    }
}
