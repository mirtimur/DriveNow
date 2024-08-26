protocol ProcurementViewModelProtocol: AnyObject {
    func numberOfRows() -> Int 
    func getItem(at row: Int) -> ProcurementDTO?
    func removeItem(at row: Int)
    func updateDataSource(with source: [ProcurementDTO])
}
