import Foundation

final class RecordingHistoryViewModel: NSObject {
    private var notesArray: [String] = []
    private weak var view: RecordingHistoryViewProtocol?
    
    init(view: RecordingHistoryViewProtocol) {
        self.view = view
    }
}

extension RecordingHistoryViewModel: RecordingHistoryViewModelProtocol {}
