import Foundation

struct Arrival: Decodable, Identifiable {
    let id: String
    let naptanId: String
    let stationName: String
    let lineId: String
    let lineName: String
    let platformName: String?
    let direction: String?
    let destinationName: String?
    let expectedArrival: Date
    let timeToStation: Int
    let currentLocation: String?
    let towards: String?
    let modeName: String
    
    var displayTowards: String {
        if let towards = towards, !towards.isEmpty, towards != "Check Front of Train" {
            return towards.uppercased()
        }
        if destinationName != nil {
            return "To \(destinationName!)"
        }
        if let platform = platformName, platform.contains("Platform") {
            return platform.uppercased()
        }
        return "Check Train"
    }
    
    var compositeId: String {
        [id, lineId, platformName ?? "no-platform", expectedArrival.description]
            .compactMap { $0 }
            .joined(separator: "-")
    }
}
