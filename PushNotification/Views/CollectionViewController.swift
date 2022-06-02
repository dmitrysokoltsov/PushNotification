import UIKit
import SDWebImage
import CoreData

private let reuseIdentifier = "Cell"
var imageUrls: [Entity] = []

class CollectionViewController: UICollectionViewController {
    
    @IBAction func deleteImage(_ sender: UIBarButtonItem) {
        ViewModel().deleteData()
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ViewModel().fetch()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
