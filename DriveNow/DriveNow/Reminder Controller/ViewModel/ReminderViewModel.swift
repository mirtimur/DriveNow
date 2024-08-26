import Foundation

final class ReminderViewModel: NSObject {
    private weak var view: ReminderViewProtocol?
    
    init(view: ReminderViewProtocol) {
        self.view = view
    }
}

extension RefuelingViewModel: ReminderViewModelProtocol{}
