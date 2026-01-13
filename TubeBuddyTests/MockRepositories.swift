import Foundation
@testable import TubeBuddy

// MARK: - Mock Repositories

class MockStationRepository: StationRepositoryProtocol {
    var stationsResult: Result<[Station], Error> = .success([])
    var allStationsResult: Result<StationResponse, Error> = .success(StationResponse(stopPoints: []))
    
    func stations(for lineId: String) async throws -> [Station] {
        switch stationsResult {
        case .success(let stations):
            return stations
        case .failure(let error):
            throw error
        }
    }
    
    func allStationsList() async throws -> StationResponse {
        switch allStationsResult {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}

class MockArrivalRepository: ArrivalRepositoryProtocol {
    var arrivalsResult: Result<[Arrival], Error> = .success([])
    
    func arrivals(for stopPointId: String) async throws -> [Arrival] {
        switch arrivalsResult {
        case .success(let arrivals):
            return arrivals
        case .failure(let error):
            throw error
        }
    }
}

class MockLineRepository: LineRepositoryProtocol {
    var allLineStatusesResult: Result<[Line], Error> = .success([])
    
    func allLineStatuses() async throws -> [Line] {
        switch allLineStatusesResult {
        case .success(let lines):
            return lines
        case .failure(let error):
            throw error
        }
    }
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

// Extend existing repository classes to conform to protocols
extension StationRepository: StationRepositoryProtocol {}
extension ArrivalRepository: ArrivalRepositoryProtocol {}
extension LineRepository: LineRepositoryProtocol {}

// MARK: - Mock Data Generators

struct MockDataGenerator {
    static func generateMockStations(count: Int = 3) -> [Station] {
        return (0..<count).map { index in
            Station(
                id: "station-\(index)",
                naptanId: "naptan-\(index)",
                stopType: "station",
                commonName: "Mock Station \(index)",
                modes: ["tube"],
                lines: [
                    StationLine(id: "line-\(index)", name: "Line \(index)", uri: "/line/\(index)")
                ],
                additionalProperties: [
                    StationProperty(category: "accessibility", key: "stepFreeAccess", value: "true"),
                    StationProperty(category: "accessibility", key: "liftAvailable", value: "false")
                ]
            )
        }
    }
    
    static func generateMockArrivals(count: Int = 3) -> [Arrival] {
        return (0..<count).map { index in
            Arrival(
                id: "arrival-\(index)",
                naptanId: "naptan-\(index)",
                stationName: "Mock Station \(index)",
                lineId: "line-\(index)",
                lineName: "Line \(index)",
                platformName: "Platform \(index % 2 + 1)",
                direction: index % 2 == 0 ? "northbound" : "southbound",
                destinationName: "Destination \(index)",
                expectedArrival: Date().addingTimeInterval(TimeInterval(index * 60)),
                timeToStation: index * 30,
                currentLocation: "Between stations",
                towards: "Towards Central",
                modeName: "tube"
            )
        }
    }
    
    static func generateMockLines(count: Int = 3) -> [Line] {
        return (0..<count).map { index in
            Line(
                id: "line-\(index)",
                name: "Mock Line \(index)",
                modeName: "tube",
                created: Date(),
                modified: Date(),
                lineStatuses: [
                    LineStatus(
                        id: index,
                        statusSeverity: 10,
                        statusSeverityDescription: "Good Service",
                        reason: nil,
                        created: Date()
                    )
                ],
                serviceTypes: [
                    LineServiceType(
                        name: "Regular Service",
                        uri: "/service/regular"
                    )
                ]
            )
        }
    }
}