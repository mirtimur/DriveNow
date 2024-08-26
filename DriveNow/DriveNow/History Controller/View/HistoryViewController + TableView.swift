import UIKit

extension HistoryViewContoller: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let historyDTO = viewModel.getItem(item: indexPath.row) else { return UITableViewCell() }
        
        switch historyDTO.type {
        case .service:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceTableViewCell", for: indexPath) as? ServiceTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: historyDTO)
            
            return cell
            
        case .refueling:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RefuelingTableViewCell", for: indexPath) as? RefuelingTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: historyDTO)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        viewModel.removeItem(at: indexPath.row)
        tableView.reloadData()
    }
}
