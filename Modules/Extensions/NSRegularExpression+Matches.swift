public extension NSRegularExpression {
    private enum Constants {
        static var trimmingSearchedWordsCount = 10
        static var trimmingFirstWordsCount = 20
    }

    enum PatternType {
        public static var trimmingSearchedWord = """
        (?:\\S+\\s+){0,\(Constants.trimmingSearchedWordsCount)}(\\S*)%@
        (\\S*)(?:\\s+\\S+){0,\(Constants.trimmingSearchedWordsCount)}
        """
        public static var trimmingFirstWord = "(?:\\S+\\s+){0,\(Constants.trimmingSearchedWordsCount)}"
        public static var htmlTags = "<[^>]+>"
    }

    convenience init(_ pattern: String) throws {
        try self.init(pattern: pattern)
    }

    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return (try? firstMatch(in: string, options: [], range: range)) != nil
    }

    func matches(_ string: String, insertDots: Bool = false) -> String? {
        let range = NSRange(location: 0, length: string.utf16.count)
        guard
            let match = firstMatch(in: string.lowercased(), options: [], range: range),
            let foundedRange = Range(match.range, in: string)
        else {
            return nil
        }
        var str = String(string[foundedRange])
        if insertDots {
            if !foundedRange.contains(string.startIndex) {
                str.insert(contentsOf: "...", at: str.startIndex)
            }

            if !foundedRange.contains(string.endIndex) {
                str.insert(contentsOf: "...", at: str.endIndex)
            }
        }

        return str
    }
}
