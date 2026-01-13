final class ArrivalRepository: ArrivalRepositoryProtocol {
    private let network: NetworkRequester

    init(network: NetworkRequester) {
        self.network = network
    }

    func arrivals(for stopPointId: String) async throws -> [Arrival] {
        try await network.request(.arrivals(stopPointId: stopPointId))
    }
}
