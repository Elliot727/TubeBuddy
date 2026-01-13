import Observation

@Observable
@MainActor
final class ArrivalsViewModel {
    private let repository: ArrivalRepository
    private let loader = DelayedLoader()

    private(set) var state: LoadState<[Arrival]> = .idle
    
    init(repository: ArrivalRepository) {
        self.repository = repository
    }

    func load(for stopPoint: String) async {
        loader.schedule { self.state = .loading }

        do {
            let arrivals = try await repository.arrivals(for: stopPoint)
            loader.cancel()
            state = .loaded(arrivals)
        } catch {
            loader.cancel()
            print(error)
            state = .failed(error)
        }
    }
}
