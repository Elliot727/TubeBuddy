import Foundation

extension JSONDecoder.DateDecodingStrategy {
    static let flexibleISO8601 = custom { decoder in
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)
        
        let formatters: [DateFormatter] = {
            let f1 = DateFormatter()
            f1.calendar = Calendar(identifier: .iso8601)
            f1.locale = Locale(identifier: "en_US_POSIX")
            f1.timeZone = TimeZone(secondsFromGMT: 0)
            f1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"
            
            let f2 = DateFormatter()
            f2.calendar = Calendar(identifier: .iso8601)
            f2.locale = Locale(identifier: "en_US_POSIX")
            f2.timeZone = TimeZone(secondsFromGMT: 0)
            f2.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
            
            let f3 = DateFormatter()
            f3.calendar = Calendar(identifier: .iso8601)
            f3.locale = Locale(identifier: "en_US_POSIX")
            f3.timeZone = TimeZone(secondsFromGMT: 0)
            f3.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            return [f1, f2, f3]
        }()
        
        for formatter in formatters {
            if let date = formatter.date(from: dateString) {
                return date
            }
        }
        
        throw DecodingError.dataCorrupted(
            DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Date string does not match expected formats: \(dateString)"
            )
        )
    }
}
