import Foundation

final class RefuelingViewModel: NSObject {
    private weak var view: RefuelingViewProtocol?
    
    init(view: RefuelingViewProtocol) {
        self.view = view
    }
}

extension RefuelingViewModel: RefuelingViewModelProtocol{}
