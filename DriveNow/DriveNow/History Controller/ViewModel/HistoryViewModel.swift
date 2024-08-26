import Foundation

final class HistoryViewModel: NSObject {
    private var dataSource: [HistoryDTO] = []
    
    private weak var view: HistoryViewProtocol?
    
    init(view: HistoryViewProtocol) {
        self.view = view
        do {
            dataSource = try FileCacher.manager.load(with: .history)
        } catch {
            dataSource = []
        }
    }
}

extension HistoryViewModel: HistoryViewModelProtocol {
    func numberOfRows( _ section: Int) -> Int {
        return dataSource.count
    }
    
    func getItem(item: Int) -> HistoryDTO? {
        guard dataSource.count > item else { return nil }
        
        return dataSource[item]
    }
    
    func removeItem(at row: Int) {
        dataSource.remove(at: row)
        try? FileCacher.manager.cache(dataSource, with: .history)
    }
    
    func updateDataSource(with source: [HistoryDTO]) {
        dataSource = source
        view?.updateTableView()
    }
}
