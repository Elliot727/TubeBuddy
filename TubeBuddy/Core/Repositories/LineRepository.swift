final class LineRepository: LineRepositoryProtocol {
    let network: NetworkRequester

    init(network: NetworkRequester) {
        self.network = network
    }

    func allLineStatuses() async throws -> [Line] {
        try await network.request(.allLineStatuses)
    }
}
