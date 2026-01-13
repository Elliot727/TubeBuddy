import Foundation

final class AppContainer {
    let network: NetworkRequester
    let lineRepository: LineRepository
    let stationRepository: StationRepository
    let arrivalsRepository: ArrivalRepository

    init() {
        network = NetworkClient(
            transport: URLSessionTransport(
                session: .shared,
                baseURL: URL(string: "https://api.tfl.gov.uk")!
            ),
            validator: HTTPStatusValidator(),
            errorDecoder: ApiErrorDecoder(decoder: JSONDecoder()),
            decoder: JSONResponseDecoder()
        )

        lineRepository = LineRepository(network: network)
        stationRepository = StationRepository(network: network)
        arrivalsRepository = ArrivalRepository(network: network)
    }
}
