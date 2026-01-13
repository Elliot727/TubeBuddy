import SwiftUI

struct Line: Decodable, Identifiable {
    let id: String
    let name: String
    let modeName: String
    let created: Date
    let modified: Date
    let lineStatuses: [LineStatus]
    let serviceTypes: [LineServiceType]

    private var tubeLine: TubeLine? {
        TubeLine(rawValue: id.lowercased())
    }

    var lineColor: Color {
        tubeLine?.color ?? .gray
    }

    var textColor: Color {
        tubeLine?.textColor ?? .gray
    }

    var severity: Int {
        lineStatuses.first?.statusSeverity ?? 0
    }

    var statusText: String {
        lineStatuses.first?.statusSeverityDescription ?? "OPERATIONAL"
    }
}
