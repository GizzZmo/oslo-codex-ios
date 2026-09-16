import AppIntents
import Foundation

struct PlayOsloCodexIntent: AppIntent {
    static let title: LocalizedStringResource = "Play Oslo Codex"
    static let description = IntentDescription("Open the Oslo Codex listen destinations.")

    func perform() async throws -> some IntentResult & OpensIntent {
        .result(opensIntent: OpenURLIntent(URL(string: "oslocodex://listen")!))
    }
}

struct OpenTrackIntent: AppIntent {
    static let title: LocalizedStringResource = "Open Track"

    @Parameter(title: "Track")
    var track: TrackChoice

    init() {}

    init(track: TrackChoice) {
        self.track = track
    }

    func perform() async throws -> some IntentResult & OpensIntent {
        .result(opensIntent: OpenURLIntent(URL(string: "oslocodex://track/\(track.track.slug)")!))
    }
}

struct ShareAlbumIntent: AppIntent {
    static let title: LocalizedStringResource = "Share Album"

    func perform() async throws -> some IntentResult & ReturnsValue<String> & ProvidesDialog {
        .result(
            value: Album.current.shareText,
            dialog: IntentDialog("Oslo Codex is ready to share.")
        )
    }
}

struct OpenListenLinksIntent: AppIntent {
    static let title: LocalizedStringResource = "Open Listen Links"

    func perform() async throws -> some IntentResult & OpensIntent {
        .result(opensIntent: OpenURLIntent(URL(string: "oslocodex://listen")!))
    }
}

enum IntentDonations {
    static func donateIfPossible() async {
        try? await PlayOsloCodexIntent().donate()
        try? await OpenTrackIntent(track: .osloCodex).donate()
        try? await ShareAlbumIntent().donate()
        try? await OpenListenLinksIntent().donate()
    }
}
