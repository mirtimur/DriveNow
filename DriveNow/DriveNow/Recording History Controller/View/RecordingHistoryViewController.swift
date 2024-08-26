import UIKit

class RecordingHistoryViewController: UIViewController {
    @IBOutlet private weak var odometerTextField: UITextField!
    @IBOutlet private weak var serviceTypeTextField: UITextField!
    @IBOutlet private weak var notesTextField: UITextField!
    
    var viewModel: RecordingHistoryViewModel!
    
    @IBAction private func saveButtonPressed(_ sender: UIButton) {
        let serviceDTO = ServiceDTO(
            odometer: odometerTextField.text,
            serviceType: serviceTypeTextField.text,
            notes: notesTextField.text,
            date: Date()
        )
        
        var cashedServiceDTO: [HistoryDTO]
        
        do {
            cashedServiceDTO = try FileCacher.manager.load(with: .history) as [HistoryDTO]
            cashedServiceDTO.append(HistoryDTO(with: serviceDTO))
        } catch {
            cashedServiceDTO = [HistoryDTO(with: serviceDTO)]
        }
        
        try? FileCacher.manager.cache(cashedServiceDTO, with: .history)
        NotificationCenter.default.post(name: .serviceAddedNotification, object: nil)
        
        dismiss(animated: true)
    }
}

extension RecordingHistoryViewController: RecordingHistoryViewProtocol {}
