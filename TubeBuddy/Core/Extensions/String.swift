extension String {
    var normalizedBool: Bool? {
        switch self.lowercased() {
        case "yes", "true", "1":
            true
        case "no", "false", "0":
            false
        default:
            nil
        }
    }
}
