import SwiftUI
import UIKit

@MainActor
final class LinkOpener {
    static let shared = LinkOpener()

    private init() {}

    func open(platform: PlatformLink) async {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()

        let application = UIApplication.shared
        let preferred = platform.bestURL

        if application.canOpenURL(preferred) {
            application.open(preferred)
        } else {
            application.open(platform.webURL)
        }
    }
}
