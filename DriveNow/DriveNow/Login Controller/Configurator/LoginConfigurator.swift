import UIKit

struct LoginConfigurator {
    static func configure(with name: String) -> LoginViewController {
        let viewController = LoginViewController.storyboardController()
        let viewModel = LoginViewModel(view: viewController)
        viewController.viewModel = viewModel
        
        return viewController
    }
}
