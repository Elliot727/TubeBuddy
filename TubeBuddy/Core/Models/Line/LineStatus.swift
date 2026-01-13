import Foundation

struct LineStatus: Decodable {
    let id: Int
    let statusSeverity: Int
    let statusSeverityDescription: String
    let reason: String?
    let created: Date
}
