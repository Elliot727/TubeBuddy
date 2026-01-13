import Foundation

struct Endpoint<Response> {
    let path: String
    let method: HTTPMethod
    let headers: [String: String]
    let query: [String: String]
    let body: Data?
}

extension Endpoint where Response == [Line] {
    static let allLineStatuses = Endpoint(
        path: "/Line/Mode/tube,overground,dlr,elizabeth-line/Status",
        method: .get,
        headers: [:],
        query: [:],
        body: nil
    )
}

extension Endpoint where Response == [Station] {
    static func stations(for lineId: String) -> Endpoint {
        Endpoint(
            path: "/Line/\(lineId)/StopPoints",
            method: .get,
            headers: [:],
            query: [:],
            body: nil
        )
    }
}

extension Endpoint where Response == StationResponse {
    static let allStations = Endpoint(
        path: "/StopPoint/Mode/tube,overground,elizabeth-line",
        method: .get,
        headers: [:],
        query: [:],
        body: nil
    )
}

extension Endpoint where Response == [Arrival] {
    static func arrivals(stopPointId: String) -> Endpoint {
        Endpoint(
            path: "/StopPoint/\(stopPointId)/Arrivals",
            method: .get,
            headers: [:],
            query: [:],
            body: nil
        )
    }
}
