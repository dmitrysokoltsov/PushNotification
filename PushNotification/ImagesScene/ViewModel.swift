import Foundation

protocol ViewModelProtocol {
    var items: [URL] { get }
    var reload: (() -> Void)? { get }
    
    func delete()
    func onAppear()
}

final class ViewModel: ViewModelProtocol {
    
    var items: [URL] = []
    
    var reload: (() -> Void)?
    
    private let storage: CoreDataProtocol
    
    init(storage: CoreDataProtocol) {
        self.storage = storage
    }
    
    func delete() {
        storage.deleteAllData()
        items = []
        reload?()
    }
    
    func onAppear() {
        let objects = storage.fetchData()
        let urls = objects.compactMap { object -> URL? in
            guard let stringUrl = object.stringUrl else { return nil }
            return URL(string: stringUrl)
        }
        items = urls
        reload?()
    }
}
