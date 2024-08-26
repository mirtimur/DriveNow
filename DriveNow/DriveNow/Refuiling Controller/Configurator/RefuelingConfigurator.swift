import UIKit

struct RefuelingConfigurator {
    static func configure() -> RefuelingViewController {
        let viewController = RefuelingViewController.storyboardController()
        let viewModel = RefuelingViewModel(view: viewController)
        viewController.viewModel = viewModel
        
        return viewController
    }
}
