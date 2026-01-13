import Foundation

struct ApiErrorDecoder: ErrorDecoder {
    let decoder: JSONDecoder

    func decode(from data: Data) throws -> Error {
        try decoder.decode(ApiError.self, from: data)
    }
}
