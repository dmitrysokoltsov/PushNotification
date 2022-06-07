import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBAction func buttonToSecondView(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CollectionViewController") as? CollectionViewController else { return }
        
        let storage = CoreDataService.shared
        let vm = ViewModel(storage: storage)
        vc.viewModel = vm
        vm.reload = { [weak vc] in
            vc?.reloadCollection()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
