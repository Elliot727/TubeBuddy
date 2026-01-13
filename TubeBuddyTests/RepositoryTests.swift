import Testing
import XCTest
@testable import TubeBuddy

// MARK: - Repository Tests

struct RepositoryTests {
    
    // MARK: - StationRepository Tests
    
    @Test
    func testStationRepositoryReturnsMockData() async throws {
        let mockNetwork = MockNetworkClient()
        let repository = StationRepository(network: mockNetwork)
        
        let mockStations = MockDataGenerator.generateMockStations(count: 2)
        mockNetwork.mockResponse = .success(mockStations as Any)
        
        let result = try await repository.stations(for: "mock-line-id")
        
        #expect(result.count == 2)
        #expect(result[0].commonName == "Mock Station 0")
        #expect(result[1].commonName == "Mock Station 1")
    }
    
    @Test
    func testStationRepositoryAllStationsReturnsMockData() async throws {
        let mockNetwork = MockNetworkClient()
        let repository = StationRepository(network: mockNetwork)
        
        let mockStations = MockDataGenerator.generateMockStations(count: 3)
        let mockResponse = StationResponse(stopPoints: mockStations)
        mockNetwork.mockResponse = .success(mockResponse as Any)
        
        let result = try await repository.allStationsList()
        
        #expect(result.stopPoints.count == 3)
        #expect(result.stopPoints[0].commonName == "Mock Station 0")
    }
    
    @Test
    func testStationRepositoryThrowsError() async throws {
        let mockNetwork = MockNetworkClient()
        let repository = StationRepository(network: mockNetwork)
        
        let mockError = NSError(domain: "TestError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Not Found"])
        mockNetwork.mockResponse = .failure(mockError)
        
        await #expect(throws: mockError) {
            _ = try await repository.stations(for: "mock-line-id")
        }
    }
    
    // MARK: - ArrivalRepository Tests
    
    @Test
    func testArrivalRepositoryReturnsMockData() async throws {
        let mockNetwork = MockNetworkClient()
        let repository = ArrivalRepository(network: mockNetwork)
        
        let mockArrivals = MockDataGenerator.generateMockArrivals(count: 2)
        mockNetwork.mockResponse = .success(mockArrivals as Any)
        
        let result = try await repository.arrivals(for: "mock-stop-point-id")
        
        #expect(result.count == 2)
        #expect(result[0].stationName == "Mock Station 0")
        #expect(result[1].stationName == "Mock Station 1")
    }
    
    @Test
    func testArrivalRepositoryThrowsError() async throws {
        let mockNetwork = MockNetworkClient()
        let repository = ArrivalRepository(network: mockNetwork)
        
        let mockError = NSError(domain: "TestError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Internal Server Error"])
        mockNetwork.mockResponse = .failure(mockError)
        
        await #expect(throws: mockError) {
            _ = try await repository.arrivals(for: "mock-stop-point-id")
        }
    }
    
    // MARK: - LineRepository Tests
    
    @Test
    func testLineRepositoryReturnsMockData() async throws {
        let mockNetwork = MockNetworkClient()
        let repository = LineRepository(network: mockNetwork)
        
        let mockLines = MockDataGenerator.generateMockLines(count: 2)
        mockNetwork.mockResponse = .success(mockLines as Any)
        
        let result = try await repository.allLineStatuses()
        
        #expect(result.count == 2)
        #expect(result[0].name == "Mock Line 0")
        #expect(result[1].name == "Mock Line 1")
    }
    
    @Test
    func testLineRepositoryThrowsError() async throws {
        let mockNetwork = MockNetworkClient()
        let repository = LineRepository(network: mockNetwork)
        
        let mockError = NSError(domain: "TestError", code: 403, userInfo: [NSLocalizedDescriptionKey: "Forbidden"])
        mockNetwork.mockResponse = .failure(mockError)
        
        await #expect(throws: mockError) {
            _ = try await repository.allLineStatuses()
        }
    }
}

// MARK: - Mock Network Client

class MockNetworkClient: NetworkRequester {
    var mockResponse: Result<Any, Error> = .success([])
    
    func request<Response>(_ endpoint: Endpoint<Response>) async throws -> Response where Response : Decodable {
        switch mockResponse {
        case .success(let data):
            if let typedData = data as? Response {
                return typedData
            } else {
                throw NSError(domain: "MockNetworkClient", code: 1, userInfo: [NSLocalizedDescriptionKey: "Type mismatch in mock response"])
            }
        case .failure(let error):
            throw error
        }
    }
}
