import UIKit

class RefuelingViewController: UIViewController {
    @IBOutlet weak var odometerTextField: UITextField!
    @IBOutlet weak var fuelTypeTextField: UITextField!
    @IBOutlet weak var quantityOfLitersTextField: UITextField!
    @IBOutlet weak var costTextField: UITextField!
    
    var viewModel: RefuelingViewModel!
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        let refuelingDTO = RefuelingDTO(
            fuelQuantity: quantityOfLitersTextField.text,
            fuelType: fuelTypeTextField.text,
            cost: costTextField.text,
            odometer: odometerTextField.text,
            date: Date()
        )
        
        var cashedServiceDTO: [HistoryDTO]
        
        do {
            cashedServiceDTO = try FileCacher.manager.load(with: .history) as [HistoryDTO]
            cashedServiceDTO.append(HistoryDTO(with: refuelingDTO))
        } catch {
            cashedServiceDTO = [HistoryDTO(with: refuelingDTO)]
        }
        
        try? FileCacher.manager.cache(cashedServiceDTO, with: .history)
        NotificationCenter.default.post(name: .refuelingAddedNotification, object: nil)
        
        dismiss(animated: true)
    }
}

extension RefuelingViewController: RefuelingViewProtocol{}
