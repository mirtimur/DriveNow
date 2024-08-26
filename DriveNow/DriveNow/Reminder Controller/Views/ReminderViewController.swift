import UIKit

class ReminderViewController: UIViewController {
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var bodyTextField: UITextField!
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    private var timeInterval = TimeInterval.zero
    
    var viewModel: ReminderViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupDataPicker() {
        datePicker.minimumDate = Date()
        
    }
    
    @IBAction private func saveButtonPressed(_ sender: UIButton) {
        let id = UUID().uuidString
        
        PushNotifications.manager.configureNotifications(
            with: titleTextField.text ?? "",
            body: bodyTextField.text ?? "",
            timeInterval: timeInterval,
            identifier: id
        )
        
        dismiss(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let startDate = Date()
        let endDate = sender.date
        let component = Calendar.current.dateComponents([.second], from: startDate, to: endDate)
        timeInterval = TimeInterval(component.second ?? .zero)
    }
}

extension ReminderViewController: ReminderViewProtocol{}
