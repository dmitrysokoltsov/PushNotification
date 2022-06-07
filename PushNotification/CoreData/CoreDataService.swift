import CoreData

protocol CoreDataProtocol {
    func saveData(_ string: String)
    func deleteAllData()
    func fetchData() -> [Entity]
}

final class CoreDataService: CoreDataProtocol {
    
    static let shared = CoreDataService()
    
    private init() { }
    
    func saveData(_ string: String) {
        let context = persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context) else {return}
        
        let taskObjet = Entity(entity: entity, insertInto: context)
        taskObjet.stringUrl = string
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteAllData() {
        let context = persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
        
        do {
            let imageUrls = try context.fetch(fetchRequest)
            
            for item in imageUrls {
                context.delete(item)
            }
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func fetchData() -> [Entity] {
        let context = persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    // MARK: - Persistent Container
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PushNotification")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
