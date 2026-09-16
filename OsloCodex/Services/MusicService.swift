import MusicKit
import UIKit

@MainActor
final class MusicService {
    static let shared = MusicService()

    private init() {}

    func openAppleMusicDestination() async {
        let status = MusicAuthorization.currentStatus
        if status == .notDetermined {
            _ = await MusicAuthorization.request()
        }

        UIApplication.shared.open(PlatformLinks.primaryAppleMusic.bestURL)
    }
}
