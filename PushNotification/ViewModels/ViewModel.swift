//
//  ViewModel.swift
//  PushNotification
//
//  Created by Dmitry Sokoltsov on 02.06.2022.
//

import Foundation
import UIKit
import CoreData

class ViewModel: Data {
    
    func saveData(_ string: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context) else {return}
        
        let taskObjet = Entity(entity: entity, insertInto: context)
        taskObjet.stringUrl = string
        do {
            try context.save()
            imageUrls.append(taskObjet)
//            imageUrls.append(taskObjet)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    func deleteData() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = CoreData().appDelegate.persistentContainer.viewContext
        
        
        if let imageUrls = try? context.fetch(CoreData().fetchRequest) {
            for item in imageUrls {
                context.delete(item)
            }
        }
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
//        imageUrls.removeAll()
        imageUrls.removeAll()
    }
    
    func fetch() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
        
        do {
             imageUrls = try context.fetch(fetchRequest)
//            imageUrls = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
