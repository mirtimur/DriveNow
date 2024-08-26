import UIKit

struct AlertMenuConfigurator {
    static func configure() -> AlertMenuViewController {
        let viewController = AlertMenuViewController.storyboardController()
        let viewModel = AlertMenuViewModel(view: viewController)
        viewController.viewModel = viewModel
        viewController.modalPresentationStyle = .fullScreen
        viewController.tabBarItem.title = "Drive Now"
       
        return viewController
    }
}
