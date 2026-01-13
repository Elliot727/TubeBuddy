import Foundation

@Observable
@MainActor
final class LineStationsViewModel {
    private let repository: StationRepository
    private let cache: StationCache
    private var scope: LineScope
    private let loader = DelayedLoader()
    
    private var allStations: [Station] = []
    
    private(set) var state: LoadState<[Station]> = .idle
    
    init(repository: StationRepository, cache: StationCache = StationCache(), scope: LineScope = .all) {
        self.repository = repository
        self.cache = cache
        self.scope = scope
    }
    
    func load() async {
        loader.schedule { self.state = .loading }
        
        do {
            let stations = try await resolveStations()
            loader.cancel()
            state = .loaded(normalize(stations))
        } catch {
            loader.cancel()
            state = .failed(error)
        }
    }
    
    func setScope(_ scope: LineScope) {
        self.scope = scope
        Task { await load() }
    }
    
    private func resolveStations() async throws -> [Station] {
        if allStations.isEmpty {
            if let cached = await cache.load() {
                allStations = cached
            } else {
                let fetched = try await repository.allStationsList()
                let parentsOnly = fetched.stopPoints.filter { station in
                    station.stopType == "NaptanMetroStation" ||
                    station.stopType == "NaptanRailStation" ||
                    station.stopType == "TransportInterchange"
                }
                allStations = parentsOnly
                await cache.save(parentsOnly)
            }
        }
        
        switch scope {
        case .all:
            return allStations
        case .line(let id):
            return allStations.filter { $0.lines.contains { $0.id == id } }
        }
    }
    
    private func normalize(_ stations: [Station]) -> [Station] {
        var mergedStations = [String: Station]()

        func baseName(for name: String) -> String {
            name
                .replacingOccurrences(of: #"(?i)\s+rail$"#, with: "", options: .regularExpression)
                .replacingOccurrences(of: #"(?i)\s+\(.*Line\)$"#, with: "", options: .regularExpression)
                .trimmingCharacters(in: .whitespacesAndNewlines)
        }

        for station in stations {
            let key = baseName(for: station.displayName)
            
            if var existing = mergedStations[key] {
                let allLines = Set(existing.lines.map { $0.id } + station.lines.map { $0.id })
                existing.lines = allLines.map { id in
                    station.lines.first(where: { $0.id == id }) ?? existing.lines.first(where: { $0.id == id })!
                }
                let allModes = Set(existing.modes + station.modes)
                existing.modes = Array(allModes)
                
                mergedStations[key] = existing
            } else {
                mergedStations[key] = station
            }
        }

        let result = mergedStations.values.sorted { $0.displayName < $1.displayName }

        return Array(result)
    }

}
