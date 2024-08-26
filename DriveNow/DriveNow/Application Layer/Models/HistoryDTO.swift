import Foundation

enum HistoryType: Codable {
    case service
    case refueling
}

struct ServiceDTO: Codable {
    let odometer: String?
    let serviceType: String?
    let notes: String?
    let date: Date
    
    var type: HistoryType {
        return .service
    }
}

struct RefuelingDTO: Codable {
    let fuelQuantity: String?
    let fuelType: String?
    let cost: String?
    let odometer: String?
    let date: Date
    
    var type: HistoryType {
        return .refueling
    }
}

struct HistoryDTO: Codable {
    let odometer: String?
    let serviceType: String?
    let notes: String?
    let fuelQuantity: String?
    let fuelType: String?
    let cost: String?
    let date: Date
    let type: HistoryType
    
    init(with serviceDTO: ServiceDTO) {
        self.odometer = serviceDTO.odometer
        self.serviceType = serviceDTO.serviceType
        self.notes = serviceDTO.notes
        self.date = serviceDTO.date
        self.type = serviceDTO.type
        self.fuelQuantity = nil
        self.fuelType = nil
        self.cost = nil
    }
    
    init(with refuelingDTO: RefuelingDTO) {
        self.fuelQuantity = refuelingDTO.fuelQuantity
        self.fuelType = refuelingDTO.fuelType
        self.cost = refuelingDTO.cost
        self.odometer = refuelingDTO.odometer
        self.date = refuelingDTO.date
        self.type = refuelingDTO.type
        self.serviceType = nil
        self.notes = nil
    }
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        return dateFormatter.string(from: date)
    }
}

struct SettingsDTO: Codable {
    let name: String?
    let nameOfCar: String?
    let typeOfFuel: String?
}
