import SwiftUI

struct HomeView: View {
    @Bindable var router: AppRouter
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var animateCover = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ZStack(alignment: .bottomLeading) {
                        Image("OsloCodexCover")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 420)
                            .clipped()
                            .scaleEffect(reduceMotion ? 1 : (animateCover ? 1.05 : 1))
                            .animation(reduceMotion ? nil : .easeInOut(duration: 12).repeatForever(autoreverses: true), value: animateCover)
                            .overlay(
                                LinearGradient(
                                    colors: [.clear, Palette.background.opacity(0.92)],
                                    startPoint: .center,
                                    endPoint: .bottom
                                )
                            )

                        VStack(alignment: .leading, spacing: 10) {
                            Text(Album.current.title.uppercased())
                                .font(.system(.largeTitle, design: .rounded, weight: .black))
                                .foregroundStyle(Palette.ink)
                            Text(Album.current.artist)
                                .font(.title3.weight(.medium))
                                .foregroundStyle(Palette.ice)
                        }
                        .padding(24)
                    }
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                    .onAppear {
                        guard !reduceMotion else { return }
                        animateCover = true
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 32, style: .continuous)
                            .stroke(Palette.ice.opacity(0.18), lineWidth: 1)
                    )

                    VStack(alignment: .leading, spacing: 16) {
                        Text(Album.current.localizedTagline)
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(Palette.ink)

                        Text(Album.current.localizedAbout)
                            .font(.body)
                            .foregroundStyle(Palette.muted)

                        HStack(spacing: 12) {
                            Button(String(localized: "listen_now")) {
                                router.isListenSheetPresented = true
                            }
                            .buttonStyle(GlassButtonStyle())
                            .accessibilityIdentifier("listen-now")

                            ShareLink(item: Album.current.shareText) {
                                Label(String(localized: "share_album"), systemImage: "square.and.arrow.up")
                            }
                            .buttonStyle(GlassButtonStyle())
                        }

                        Button(String(localized: "add_to_apple_music")) {
                            Task {
                                await MusicService.shared.openAppleMusicDestination()
                            }
                        }
                        .buttonStyle(GlassButtonStyle())
                    }
                    .padding(.horizontal, 4)

                    VStack(alignment: .leading, spacing: 12) {
                        Text(String(localized: "tracks_section"))
                            .font(.title2.bold())
                            .foregroundStyle(Palette.ink)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                ForEach(Album.current.tracks) { track in
                                    Button {
                                        router.selectedTab = .tracks
                                        router.selectedTrack = track
                                    } label: {
                                        VStack(alignment: .leading, spacing: 10) {
                                            Text("0\(track.index)")
                                                .font(.caption.weight(.bold))
                                                .foregroundStyle(Palette.neon)
                                            Text(track.title)
                                                .font(.headline)
                                                .foregroundStyle(Palette.ink)
                                            Text(track.duration)
                                                .font(.subheadline)
                                                .foregroundStyle(Palette.muted)
                                        }
                                        .padding(18)
                                        .frame(width: 180, alignment: .leading)
                                        .background(Palette.backgroundElevated, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text(String(localized: "places_section"))
                            .font(.title2.bold())
                            .foregroundStyle(Palette.ink)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(Album.current.places) { place in
                                    Button(place.title) {
                                        router.selectedTab = .oslo
                                    }
                                    .buttonStyle(GlassButtonStyle())
                                }
                            }
                        }
                    }

                    Link(destination: PlatformLinks.relatedSoundCloud.bestURL) {
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Nordic Noir and Neon Circuits")
                                    .font(.headline)
                                    .foregroundStyle(Palette.ink)
                                Text(String(localized: "related_drop_subtitle"))
                                    .font(.subheadline)
                                    .foregroundStyle(Palette.muted)
                            }
                            Spacer()
                            Image(systemName: "arrow.up.forward")
                                .foregroundStyle(Palette.neon)
                        }
                        .padding(18)
                        .background(Palette.backgroundElevated, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                    }
                }
                .padding(20)
            }
            .background(Palette.background.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Oslo Codex")
                        .foregroundStyle(Palette.ice)
                        .font(.headline)
                }
            }
        }
    }
}
