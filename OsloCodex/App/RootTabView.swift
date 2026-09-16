import SwiftUI

struct RootTabView: View {
    @Bindable var router: AppRouter

    var body: some View {
        TabView(selection: $router.selectedTab) {
            HomeView(router: router)
                .tabItem {
                    Label(String(localized: "tab_codex"), systemImage: "sparkles.tv")
                }
                .tag(AppRouter.Tab.codex)

            TracksView(router: router)
                .tabItem {
                    Label(String(localized: "tab_tracks"), systemImage: "music.note.list")
                }
                .tag(AppRouter.Tab.tracks)

            PlacesView(router: router)
                .tabItem {
                    Label(String(localized: "tab_oslo"), systemImage: "map")
                }
                .tag(AppRouter.Tab.oslo)

            ArtistView()
                .tabItem {
                    Label(String(localized: "tab_artist"), systemImage: "person.crop.square")
                }
                .tag(AppRouter.Tab.artist)
        }
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarBackground(.thinMaterial, for: .tabBar)
        .sheet(isPresented: $router.isListenSheetPresented) {
            ListenSheet(platforms: Album.current.listenPlatforms)
                .presentationDetents([.fraction(0.55), .large])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(28)
        }
        .sheet(item: $router.shareTarget) { target in
            ActivityView(items: [shareText(for: target)])
        }
        .tint(Palette.neon)
        .background(Palette.background.ignoresSafeArea())
    }

    private func shareText(for target: AppRouter.ShareTarget) -> String {
        switch target {
        case .album:
            Album.current.shareText
        }
    }
}
