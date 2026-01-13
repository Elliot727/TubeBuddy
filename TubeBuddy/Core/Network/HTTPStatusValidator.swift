import Foundation

struct HTTPStatusValidator: ResponseValidator {
    func validate(_ response: HTTPURLResponse) throws {
        switch response.statusCode {
        case 200...299:
            return
        default:
            throw NetworkError.invalidResponse
        }
    }
}
