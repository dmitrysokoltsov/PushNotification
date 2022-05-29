//
//  CollectionViewController.swift
//  PushNotification
//
//  Created by Dmitry Sokoltsov on 27.05.2022.
//

import UIKit
import SDWebImage
import CoreData

private let reuseIdentifier = "Cell"
var imageUrls: [Entity] = []

class CollectionViewController: UICollectionViewController {
    
    @IBAction func addUrl(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New url", message: "Enter new url", preferredStyle: .alert)
        
        let newUrl = UIAlertAction(title: "Save", style: .default) { url in
            let tf = alert.textFields?.first
            if let newUrl = tf?.text {
                self.saveNewUrl(newUrl)
                self.collectionView.reloadData()
            }
        }
        alert.addTextField()
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(newUrl)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @IBAction func deleteImage(_ sender: UIBarButtonItem) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
        
        if let imageUrls = try? context.fetch(fetchRequest) {
            for item in imageUrls {
                context.delete(item)
            }
        }
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        imageUrls.removeAll()
        self.collectionView.reloadData()
    }
    
    func saveNewUrl(_ string: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context) else {return}
        
        let taskObjet = Entity(entity: entity, insertInto: context)
        taskObjet.stringUrl = string
        do {
            try context.save()
            imageUrls.append(taskObjet)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
        
        do {
            imageUrls = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageUrls.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        let imageUrl = imageUrls[indexPath.row]
        let currentImageUrl = imageUrl.stringUrl
        guard let url = URL(string: currentImageUrl ?? "") else {return cell}
        
        cell.imageCell.sd_setImage(with: url, completed: nil)
        
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
