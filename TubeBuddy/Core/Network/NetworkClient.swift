final class NetworkClient: NetworkRequester {
    let transport: NetworkTransport
    let validator: ResponseValidator
    let errorDecoder: ErrorDecoder
    let decoder: ResponseDecoder

    init(
        transport: NetworkTransport,
        validator: ResponseValidator,
        errorDecoder: ErrorDecoder,
        decoder: ResponseDecoder
    ) {
        self.transport = transport
        self.validator = validator
        self.errorDecoder = errorDecoder
        self.decoder = decoder
    }

    func request<Response: Decodable>(_ endpoint: Endpoint<Response>) async throws -> Response {
        let (data, response) = try await transport.send(endpoint)
        do {
            try validator.validate(response)
        } catch {
            throw (try? errorDecoder.decode(from: data)) ?? error
        }
        return try decoder.decode(Response.self, from: data)
    }
}
