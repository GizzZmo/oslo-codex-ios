import SwiftUI

struct TrackDetailView: View {
    let track: Track

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image("OsloCodexCover")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))

                VStack(alignment: .leading, spacing: 8) {
                    Text(track.title)
                        .font(.largeTitle.bold())
                        .foregroundStyle(Palette.ink)
                    Text(track.duration)
                        .font(.headline)
                        .foregroundStyle(Palette.ice)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(String(localized: "credits_title"))
                        .font(.title3.bold())
                        .foregroundStyle(Palette.ink)
                    Text("\(String(localized: "writer_label")): \(track.credits.writer)")
                        .foregroundStyle(Palette.muted)
                    Text("\(String(localized: "producer_label")): \(track.credits.producer)")
                        .foregroundStyle(Palette.muted)
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text(String(localized: "lyrics_title"))
                        .font(.title3.bold())
                        .foregroundStyle(Palette.ink)
                    Text(LyricsLoader.lyrics(for: track))
                        .foregroundStyle(Palette.ink)
                        .textSelection(.enabled)
                }
                .padding(18)
                .background(Palette.backgroundElevated, in: RoundedRectangle(cornerRadius: 24, style: .continuous))

                VStack(alignment: .leading, spacing: 12) {
                    Text(String(localized: "listen_row_title"))
                        .font(.title3.bold())
                        .foregroundStyle(Palette.ink)
                    ForEach(track.platforms) { platform in
                        Button {
                            Task {
                                await LinkOpener.shared.open(platform: platform)
                            }
                        } label: {
                            PlatformTile(platform: platform)
                        }
                        .buttonStyle(.plain)
                    }
                }

                ShareLink(item: track.shareText) {
                    Label(String(localized: "share_track"), systemImage: "square.and.arrow.up")
                }
                .buttonStyle(GlassButtonStyle())
            }
            .padding(20)
        }
        .background(Palette.background.ignoresSafeArea())
    }
}
