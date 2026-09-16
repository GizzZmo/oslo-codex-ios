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

        if raw.hasPrefix("---"),
           let closingRange = raw.range(of: "\n---\n") {
            let content = raw[closingRange.upperBound...]
            return content.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        return raw.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
