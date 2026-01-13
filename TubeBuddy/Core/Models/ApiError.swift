struct ApiError: Decodable, Error {
    let timestampUtc: String
    let exceptionType: String
    let httpStatusCode: Int
    let httpStatus: String
    let relativeUri: String
    let message: String
}
