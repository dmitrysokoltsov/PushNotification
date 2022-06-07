import UIKit
import SDWebImage

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    var viewModel: ViewModelProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.onAppear()
    }
    
    //MARK: - Public Methods
    func reloadCollection() {
        collectionView.reloadData()
    }

    // MARK: - Actions
    @IBAction func deleteImage(_ sender: UIBarButtonItem) {
        viewModel?.delete()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        guard let url = viewModel?.items[indexPath.row] else { return cell }
        
        cell.imageCell.sd_setImage(with: url, completed: nil)
        
        return cell
    }
}
