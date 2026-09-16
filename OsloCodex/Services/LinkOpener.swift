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
        if let nativeURL = platform.nativeURL,
           application.canOpenURL(nativeURL) {
            application.open(nativeURL)
            return
        }

        application.open(platform.webURL)
    }
}
