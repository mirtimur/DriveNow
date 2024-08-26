import Foundation

final class LoginViewModel: NSObject {
    private weak var view: LoginViewProtocol?
    
    init(view: LoginViewProtocol) {
        self.view = view
    }
}

extension LoginViewModel: LoginViewModelProtocol {
    func registerButtonPressed() {
        view?.reloadData()
    }
}
