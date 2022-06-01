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
}
