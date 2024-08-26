import UIKit

class ProcurementViewController: UIViewController {
    
    @IBOutlet private weak var procurementTableView: UITableView!
    
    var viewModel: ProcurementViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupProcurementTableView()
        setupNotifications()
    }
    
    private func setupProcurementTableView() {
        procurementTableView.register(UINib(nibName: "ProcurementTableViewCell", bundle: nil), forCellReuseIdentifier: "ProcurementTableViewCell")
        procurementTableView.dataSource = self
        procurementTableView.delegate = self
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(procurementAddedNotification), name: .procurementAddedNotification, object: nil)
    }
    
    @objc private func procurementAddedNotification() {
        do {
            let cachedProcurementDTO = try FileCacher.manager.load(with: .procurement) as [ProcurementDTO]
            viewModel.updateDataSource(with: cachedProcurementDTO)
        } catch {
            print(error)
        }
    }
}

extension ProcurementViewController: ProcurementViewProtocol {
    func updateTableView() {
        procurementTableView.reloadData()
    }
}
