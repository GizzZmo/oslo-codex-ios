import Foundation

enum LyricsLoader {
    static func lyrics(for track: Track) -> String {
        guard let url = Bundle.main.url(forResource: track.lyricResourceName, withExtension: "md", subdirectory: "Data/Lyrics"),
              let raw = try? String(contentsOf: url, encoding: .utf8) else {
            return String(localized: "lyrics_coming")
        }

        if raw.contains("status: placeholder") {
            return String(localized: "lyrics_coming")
        }

        if raw.hasPrefix("---\n") {
            let searchStart = raw.index(raw.startIndex, offsetBy: 4)
            if let closingRange = raw.range(of: "\n---\n", range: searchStart..<raw.endIndex) {
                let content = raw[closingRange.upperBound...]
                return content.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }

        if raw.hasPrefix("---\r\n") {
            let searchStart = raw.index(raw.startIndex, offsetBy: 5)
            if let closingRange = raw.range(of: "\r\n---\r\n", range: searchStart..<raw.endIndex) {
                let content = raw[closingRange.upperBound...]
                return content.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }

        if raw.hasPrefix("---"),
           let closingRange = raw.range(of: "\n---\n", options: .backwards) {
            let content = raw[closingRange.upperBound...]
            return content.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        return raw.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
