import Foundation

struct JSONResponseDecoder: ResponseDecoder {
    let decoder: JSONDecoder

    init() {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .flexibleISO8601
        self.decoder = decoder
    }

    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        try decoder.decode(type, from: data)
    }
}
