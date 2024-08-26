import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameOfCarLabel: UILabel!
    @IBOutlet weak var nameOfCarTextField: UITextField!
    @IBOutlet weak var typeOfFuelLabel: UILabel!
    @IBOutlet weak var typeOfFuelTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCashedProfileInfo()
    }
    
    private func getCashedProfileInfo() {
        let profileInfo = try? FileCacher.manager.load(with: .settings) as SettingsDTO
        
        guard let profileInfo else { return }
        
        if let name = profileInfo.name {
            nameTextField.text = name
        }
        
        if let nameOfCar = profileInfo.nameOfCar {
            nameOfCarTextField.text = nameOfCar
        }
        
        if let typeOfFuel = profileInfo.typeOfFuel {
            typeOfFuelTextField.text = typeOfFuel
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        try? FileCacher.manager.cache(
            SettingsDTO (
                name: nameTextField.text,
                nameOfCar: nameOfCarTextField.text,
                typeOfFuel: typeOfFuelTextField.text
            ),
            with: .settings
        )
        NotificationCenter.default.post(name: .refuelingAddedNotification, object: nil)
    }
}
