import UIKit

class HistoryViewContoller: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: HistoryViewModel!
    private var isAppear = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupTableView()
        setupNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard !isAppear else { return }
        
        PushNotifications.manager.requestAuthorization()
        isAppear = true
    }
    
   private func setupTableView() {
       tableView.register(UINib(nibName: "ServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "ServiceTableViewCell")
       tableView.register(UINib(nibName: "RefuelingTableViewCell", bundle: nil), forCellReuseIdentifier: "RefuelingTableViewCell")
       tableView.dataSource = self
       tableView.delegate = self
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(serviceAddedNotification), name: .serviceAddedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refuelingAddedNotification), name: .refuelingAddedNotification, object: nil)
    }
    
    @objc private func serviceAddedNotification() {
        do {
            let cachedServiceDTO = try FileCacher.manager.load(with: .history) as [HistoryDTO]
            viewModel.updateDataSource(with: cachedServiceDTO)
        } catch {
            print(error)
        }
    }
    
    @objc private func refuelingAddedNotification() {
        do {
            let cachedServiceDTO = try FileCacher.manager.load(with: .history) as [HistoryDTO]
            viewModel.updateDataSource(with: cachedServiceDTO)
        } catch {
            print(error)
        }
    }
}

extension HistoryViewContoller: HistoryViewProtocol {
    func updateTableView() {
        tableView.reloadData()
    }
}
