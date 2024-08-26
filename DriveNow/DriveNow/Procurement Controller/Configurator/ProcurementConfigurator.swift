import UIKit

struct ProcurementConfigurator {
    static func configure() -> ProcurementViewController {
        let viewController = ProcurementViewController.storyboardController()
        let viewModel = ProcurementViewModel(view: viewController)
        viewController.viewModel = viewModel
        viewController.tabBarItem.title = "Покупки"
        viewController.tabBarItem.image = UIImage(systemName: "list.bullet")
        viewController.modalPresentationStyle = .fullScreen
       
        return viewController
    }
}
