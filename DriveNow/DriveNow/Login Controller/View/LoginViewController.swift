import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private weak var salutationLabel: UILabel!
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var googleSignUpButton: UIButton!
    
    var viewModel: LoginViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func registerButtonPressed(_ sender: UIButton) {
        viewModel.registerButtonPressed()
        
    }
    
    @IBAction private func googleSignUpButtonPressed(_ sender: UIButton) {
        
    }
}

extension LoginViewController: LoginViewProtocol {
    func reloadData() {
        print("")
    }
}
