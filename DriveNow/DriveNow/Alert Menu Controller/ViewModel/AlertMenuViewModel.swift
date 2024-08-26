import Foundation

final class AlertMenuViewModel: NSObject {
    private weak var view: AlertMenuViewProtocol?
    
    init(view: AlertMenuViewProtocol) {
        self.view = view
    }
}

extension AlertMenuViewModel: AlertMenuViewModelProtocol {}
