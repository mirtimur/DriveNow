import Foundation

struct ProcurementDTO: Codable {
    let procurement: String
    let date: Date
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        return dateFormatter.string(from: date)
    }
}
