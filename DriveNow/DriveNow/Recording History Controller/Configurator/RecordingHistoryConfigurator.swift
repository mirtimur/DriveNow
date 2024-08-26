import UIKit

struct RecordingHistoryConfigurator {
    static func configure() -> RecordingHistoryViewController {
        let viewController = RecordingHistoryViewController.storyboardController()
        let viewModel = RecordingHistoryViewModel(view: viewController)
        viewController.viewModel = viewModel
        
        return viewController
    }
}

