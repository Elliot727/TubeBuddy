import Observation

@Observable
@MainActor
final class LineStatusViewModel {
    private let repository: LineRepository
    private let loader = DelayedLoader()

    private(set) var state: LoadState<[Line]> = .idle

    init(repository: LineRepository) {
        self.repository = repository
        Task { await load() }
    }

    func load() async {
        loader.schedule { self.state = .loading }

        do {
            let lines = try await repository.allLineStatuses()
            loader.cancel()
            state = .loaded(lines)
        } catch {
            loader.cancel()
            state = .failed(error)
        }
    }
}
