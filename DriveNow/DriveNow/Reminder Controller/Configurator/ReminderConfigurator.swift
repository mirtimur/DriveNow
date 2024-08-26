import UIKit

struct ReminderConfigurator {
    static func configure() -> ReminderViewController {
        let viewController = ReminderViewController.storyboardController()
        let viewModel = ReminderViewModel(view: viewController)
        viewController.viewModel = viewModel
        
        return viewController
    }
}
