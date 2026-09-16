import UIKit

@MainActor
final class MusicService {
    static let shared = MusicService()

    private init() {}

    func openAppleMusicDestination() async {
        UIApplication.shared.open(PlatformLinks.primaryAppleMusic.bestURL)
    }
}
