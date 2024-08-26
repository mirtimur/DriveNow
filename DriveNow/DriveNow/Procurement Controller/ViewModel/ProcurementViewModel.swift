import Foundation

final class ProcurementViewModel: NSObject {
    private var dataSource: [ProcurementDTO] = []
    private weak var view: ProcurementViewProtocol?
    
    init(view: ProcurementViewProtocol) {
        self.view = view
        do {
            dataSource = try FileCacher.manager.load(with: .procurement)
        } catch {
            dataSource = []
        }
    }
}

extension ProcurementViewModel: ProcurementViewModelProtocol {
    func numberOfRows() -> Int {
        return dataSource.count
    }
    
    func getItem(at row: Int) -> ProcurementDTO? {
        guard dataSource.count > row else { return nil }
        
        return dataSource[row]
    }
    
    func removeItem(at row: Int) {
        dataSource.remove(at: row)
        try? FileCacher.manager.cache(dataSource, with: .procurement)
    }
    
    func updateDataSource(with source: [ProcurementDTO]) {
        dataSource = source
        view?.updateTableView()
    }
}
