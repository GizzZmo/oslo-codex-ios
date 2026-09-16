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

    var selectedTab: Tab = .codex
    var selectedTrack: Track?
    var isListenSheetPresented = false

    func handle(url: URL) {
        guard url.scheme == "oslocodex" else { return }

        switch url.host {
        case "listen":
            selectedTab = .codex
            isListenSheetPresented = true
        case "track":
            isListenSheetPresented = false
            guard let slug = url.pathComponents.dropFirst().first,
                  let track = Album.current.track(slug: slug) else {
                return
            }
            selectedTab = .tracks
            selectedTrack = track
        case "places":
            isListenSheetPresented = false
            selectedTab = .oslo
        case "artist":
            isListenSheetPresented = false
            selectedTab = .artist
        default:
            break
        }
    }
}
