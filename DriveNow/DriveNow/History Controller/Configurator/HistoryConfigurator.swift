import UIKit

struct HistoryConfigurator {
    static func configure() -> HistoryViewContoller {
        let viewController = HistoryViewContoller.storyboardController()
        let viewModel = HistoryViewModel(view: viewController)
        viewController.viewModel = viewModel
        
        return viewController
    }
}
