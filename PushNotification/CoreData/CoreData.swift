import CoreData
import UIKit

class CoreData {
    let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
}


