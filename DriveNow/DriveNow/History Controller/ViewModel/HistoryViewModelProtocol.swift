protocol HistoryViewModelProtocol: AnyObject {
    func numberOfRows( _ section: Int) -> Int
    func getItem(item: Int) -> HistoryDTO?
    func removeItem(at row: Int)
    func updateDataSource(with source: [HistoryDTO])
}
