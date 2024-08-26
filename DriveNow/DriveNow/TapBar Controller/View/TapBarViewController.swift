import UIKit

class TapBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTapBar()
        delegate = self
    }
    
    private func setupTapBar() {
        let middleButtonDiameter: CGFloat = 42
        
        lazy var middleButton: UIButton = {
            let middleButton = UIButton()
            middleButton.layer.cornerRadius = middleButtonDiameter / 2
            middleButton.backgroundColor = .black
            middleButton.translatesAutoresizingMaskIntoConstraints = false
            return middleButton
        }()
        
        lazy var plusImageView: UIImageView = {
            let plusImageView = UIImageView()
            plusImageView.image = UIImage(systemName: "gear.badge")
            plusImageView.tintColor = .white
            plusImageView.translatesAutoresizingMaskIntoConstraints = false
            return plusImageView
        }()
        
        //MARK: - Make UI
        tabBar.addSubview(middleButton)
        middleButton.addSubview(plusImageView)
        
        NSLayoutConstraint.activate([
            middleButton.heightAnchor.constraint(equalToConstant: middleButtonDiameter),
            middleButton.widthAnchor.constraint(equalToConstant: middleButtonDiameter),
            middleButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            middleButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            plusImageView.heightAnchor.constraint(equalToConstant: 15),
            plusImageView.widthAnchor.constraint(equalToConstant: 18),
            plusImageView.centerXAnchor.constraint(equalTo: middleButton.centerXAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: middleButton.centerYAnchor)
        ])
        
        let historyVC = HistoryConfigurator.configure()
        historyVC.tabBarItem.title = "История"
        historyVC.tabBarItem.image = UIImage(systemName: "clock")
        historyVC.modalPresentationStyle = .fullScreen
        
        let procurementVC = ProcurementConfigurator.configure()
        
        let middleVC = AlertMenuConfigurator.configure()
        
        let mapVC = ServiceMapViewController.storyboardController()
        mapVC.tabBarItem.title = "Карта"
        mapVC.tabBarItem.image = UIImage(systemName: "mappin.circle.fill")
        mapVC.modalPresentationStyle = .fullScreen
        
        let settingsVC = SettingsViewController.storyboardController()
        settingsVC.tabBarItem.title = "Больше"
        settingsVC.tabBarItem.image = UIImage(systemName: "ellipsis")
        settingsVC.modalPresentationStyle = .fullScreen
        
        viewControllers = [historyVC, procurementVC, middleVC, mapVC, settingsVC]
    }
    
    private func addAlert() {
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        let serviceAction = UIAlertAction(
            title: "Сервис",
            style: .default
        ) { [weak self] action in
            let recordingHistoryVc = RecordingHistoryConfigurator.configure()
            self?.present(recordingHistoryVc, animated: true, completion: nil)
        }
        
        let reminderAction = UIAlertAction (
            title: "Напоминание",
            style: .default
        ) { [weak self] action in
            let reminderVc = ReminderConfigurator.configure()
            self?.present(reminderVc, animated: true, completion: nil)
        }
        
        let refuelingAction = UIAlertAction (
            title: "Заправка",
            style: .default
        ) { [weak self] action in
            let refuelingVc = RefuelingConfigurator.configure()
            self?.present(refuelingVc, animated: true, completion: nil)
        }
        
        let purchaseAction = UIAlertAction (
            title: "Новая покупка",
            style: .default
        ) { [weak self] action in
            self?.addProcurementAlert()
        }
        
        let cancelAction = UIAlertAction(
            title: "Отмена",
            style: .cancel
        )
        alert.addAction(serviceAction)
        alert.addAction(cancelAction)
        alert.addAction(reminderAction)
        alert.addAction(refuelingAction)
        alert.addAction(purchaseAction)
        present(alert, animated: true)
    }
    
    private func addProcurementAlert() {
        let alert = UIAlertController(
            title: "Новая запись",
            message: "Добавьте новую покупку",
            preferredStyle: .alert
        )
        let saveAction = UIAlertAction(
            title: "Сохранить",
            style: .default
        ) { action in
            guard let fields = alert.textFields, fields.count == 1 else {
                return
            }
            
            let nameToSave = fields[0].text
            
            var cashedProcurementDTO: [ProcurementDTO]
            
            do {
                cashedProcurementDTO = try FileCacher.manager.load(with: .procurement) as [ProcurementDTO]
                cashedProcurementDTO.append(ProcurementDTO(procurement: nameToSave ?? "", date: Date()))
            } catch {
                cashedProcurementDTO = [ProcurementDTO(procurement: nameToSave ?? "", date: Date())]
            }
            
            try? FileCacher.manager.cache(cashedProcurementDTO, with: .procurement)
            NotificationCenter.default.post(name: .procurementAddedNotification, object: nil)
            
        }
        let cancelAction = UIAlertAction(
            title: "Отмена",
            style: .cancel
        )
        alert.addTextField()
        guard let fields = alert.textFields,
              fields.count == 1 else { return }
        
        fields[0].placeholder = "Новая покупка:"
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

extension TapBarViewController: UITabBarControllerDelegate {
    func  tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        switch viewController {
        case is AlertMenuViewController:
            addAlert()
            return false
            
        default:
            return true
        }
    }
}
