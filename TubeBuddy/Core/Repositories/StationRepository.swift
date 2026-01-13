final class StationRepository: StationRepositoryProtocol {
    private let network: NetworkRequester

    init(network: NetworkRequester) {
        self.network = network
    }

    func stations(for lineId: String) async throws ->  [Station]{
        try await network.request(.stations(for: lineId))
    }

    func allStationsList() async throws -> StationResponse {
        try await network.request(.allStations)
    }
}
