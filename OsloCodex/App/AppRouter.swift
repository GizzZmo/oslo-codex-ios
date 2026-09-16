import Foundation
import Observation

@Observable
final class AppRouter {
    enum Tab: Hashable {
        case codex
        case tracks
        case oslo
        case artist
    }

    enum ShareTarget: String, Identifiable {
        case album

        var id: String { rawValue }
    }

    var selectedTab: Tab = .codex
    var selectedTrack: Track?
    var isListenSheetPresented = false
    var shareTarget: ShareTarget?

    func handle(url: URL) {
        guard url.scheme == "oslocodex" else { return }

        switch url.host {
        case "listen":
            selectedTab = .codex
            isListenSheetPresented = true
        case "track":
            guard let slug = url.pathComponents.dropFirst().first,
                  let track = Album.current.track(slug: slug) else {
                return
            }
            selectedTab = .tracks
            selectedTrack = track
        case "places":
            selectedTab = .oslo
        case "artist":
            selectedTab = .artist
        case "share":
            selectedTab = .codex
            shareTarget = .album
        default:
            break
        }
    }
}
