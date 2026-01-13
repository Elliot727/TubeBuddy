import Foundation

final class URLSessionTransport: NetworkTransport {
    let session: URLSession
    let baseURL: URL
    
    init(session: URLSession, baseURL: URL) {
        self.session = session
        self.baseURL = baseURL
    }

    func send<Response>(_ endpoint: Endpoint<Response>) async throws -> (Data, HTTPURLResponse) {
        let request = URLRequest(endpoint: endpoint, baseURL: baseURL)
        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        return (data, http)
    }
}
