import UIKit

extension ProcurementViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProcurementTableViewCell", for: indexPath) as? ProcurementTableViewCell,
              let note = viewModel.getItem(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.configure(with: note)
        
        return cell
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
