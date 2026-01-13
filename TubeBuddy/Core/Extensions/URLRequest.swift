import Foundation

extension URLRequest {
    init<Response>(endpoint: Endpoint<Response>, baseURL: URL) {

        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!

        let encodedPath = endpoint.path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        components.path = baseURL.path + encodedPath

        components.queryItems = endpoint.query.map { key, value in
            URLQueryItem(name: key, value: value)
        }

        let url = components.url!

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.string
        request.httpBody = endpoint.body

        endpoint.headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }

        self = request
    }
}
