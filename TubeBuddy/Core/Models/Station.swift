import Foundation
import SwiftUI

struct Station: Codable, Identifiable {
    let id: String
    let naptanId: String
    let stopType: String
    let commonName: String
    var modes: [String]
    var lines: [StationLine]
    let additionalProperties: [StationProperty]


    var displayName: String {
        commonName
            .replacingOccurrences(of: "Underground", with: "")
            .replacingOccurrences(of: "Station", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var accessibility: [AccessibilityFeature] {
        additionalProperties
            .filter { $0.category == "accessibility" }
            .map { AccessibilityFeature(property: $0) }
    }

    var accessibleFeatures: [AccessibilityFeature] {
        accessibility.filter { $0.isAvailable == true }
    }
}

struct StationLine: Codable, Identifiable {
    let id: String
    let name: String
    let uri: String
}

struct StationProperty: Codable {
    let category: String
    let key: String
    let value: String
}

struct AccessibilityFeature: Identifiable {
    let id = UUID()
    let name: String
    let isAvailable: Bool?
    let details: String?

    init(property: StationProperty) {
        name = property.key
        isAvailable = property.value.normalizedBool
        details = property.value.normalizedBool == nil ? property.value : nil
    }
}
