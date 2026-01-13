@MainActor
final class DelayedLoader {
    private let delay: Duration
    private var task: Task<Void, Never>?

    init(delay: Duration = .seconds(1)) {
        self.delay = delay
    }

    func schedule(_ action: @escaping @MainActor () -> Void) {
        task = Task {
            try? await Task.sleep(for: delay)
            guard !Task.isCancelled else { return }
            action()
        }
    }

    func cancel() {
        task?.cancel()
        task = nil
    }
}
