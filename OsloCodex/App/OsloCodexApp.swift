import SwiftUI

@main
struct OsloCodexApp: App {
    @State private var router = AppRouter()

    var body: some Scene {
        WindowGroup {
            RootTabView(router: router)
                .onOpenURL { url in
                    router.handle(url: url)
                }
                .task {
                    await IntentDonations.donateIfPossible()
                }
        }
    }
}
