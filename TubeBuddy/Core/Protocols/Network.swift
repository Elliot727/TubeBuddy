import Foundation

protocol NetworkRequester {
    func request<Response: Decodable>(_ endpoint: Endpoint<Response>) async throws -> Response
}
protocol NetworkTransport {
    func send<Response>(_ endpoint: Endpoint<Response>) async throws -> (Data, HTTPURLResponse)
}

protocol ResponseValidator {
    func validate(_ response: HTTPURLResponse) throws
}
protocol ResponseDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

protocol ErrorDecoder {
    func decode(from data: Data) throws -> Error
}

// MARK: - Repository Protocols

protocol StationRepositoryProtocol {
    func stations(for lineId: String) async throws -> [Station]
    func allStationsList() async throws -> StationResponse
}

protocol ArrivalRepositoryProtocol {
    func arrivals(for stopPointId: String) async throws -> [Arrival]
}

protocol LineRepositoryProtocol {
    func allLineStatuses() async throws -> [Line]
}
