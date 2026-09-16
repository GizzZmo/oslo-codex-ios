import SwiftUI

@main
struct OsloCodexApp: App {
    @AppStorage("didDonateIntents") private var didDonateIntents = false
    @State private var router = AppRouter()

    var body: some Scene {
        WindowGroup {
            RootTabView(router: router)
                .onOpenURL { url in
                    router.handle(url: url)
                }
                .task {
                    guard !didDonateIntents else { return }
                    await IntentDonations.donateIfPossible()
                    didDonateIntents = true
                }
        }
    }
}
