import Foundation

actor StationCache {
    private let url: URL = {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("stations_cache.json")
    }()

    func load() -> [Station]? {
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? JSONDecoder().decode([Station].self, from: data)
    }

    func save(_ stations: [Station]) {
        guard let data = try? JSONEncoder().encode(stations) else { return }
        try? data.write(to: url, options: .atomic)
    }
}
